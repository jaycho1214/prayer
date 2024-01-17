import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/i18n/strings.g.dart';
import 'package:prayer/features/group/widgets/forms/group_picker.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';
import 'package:prayer/features/group/providers/group_provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PrayerGroupForm extends HookWidget {
  const PrayerGroupForm({
    super.key,
    this.onChange,
  });

  final void Function(String?)? onChange;

  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
      name: 'groupId',
      builder: (FormFieldState<String> field) => PlayerGroupFormInner(
        groupId: field.value,
        onChange: (groupId) {
          field.didChange(groupId);
          onChange?.call(groupId);
        },
      ),
    );
  }
}

class PlayerGroupFormInner extends HookConsumerWidget {
  const PlayerGroupFormInner({
    super.key,
    this.groupId,
    this.onChange,
  });

  final String? groupId;
  final void Function(String?)? onChange;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(groupNotifierProvider(groupId));
    final group = provider.value;

    ref.listen(
      groupNotifierProvider(groupId),
      (_, next) {
        if (next.valueOrNull == null) {
          onChange?.call(null);
        }
      },
      onError: (e, st) {
        talker.error(
            "[PlayerGroupForm] failed to fetch a group: $groupId", e, st);
        onChange?.call(null);
      },
    );

    return Skeletonizer(
      enabled: groupId != null && provider.isLoading,
      child: ShrinkingButton(
        onTap: () async {
          final groupId = await GroupPicker.show(context);
          if (groupId != null) {
            onChange?.call(groupId == '' ? null : groupId);
          }
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            children: [
              Text(
                groupId == null ? t.general.community : group?.name ?? '',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
                maxLines: 1,
              ),
              const SizedBox(width: 5),
              FaIcon(
                FontAwesomeIcons.chevronDown,
                color: Theme.of(context).colorScheme.onPrimary,
                size: 12,
              )
            ],
          ),
        ),
      ),
    );
  }
}
