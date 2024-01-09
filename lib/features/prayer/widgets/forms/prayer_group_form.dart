import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer/generated/l10n.dart';
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

final conditionalGroupProvider =
    Provider.autoDispose.family((ref, String? groupId) {
  if (groupId == null) {
    return null;
  }
  return ref.watch(groupNotifierProvider(groupId));
});

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
    final provider = ref.watch(conditionalGroupProvider(groupId));
    final group = provider?.value;

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (groupId != null && !provider!.isLoading && provider.value == null) {
          onChange?.call(null);
        }
      });
      return () => null;
    }, [onChange, groupId, onChange]);

    return Skeletonizer(
      enabled: groupId != null && provider!.isLoading,
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
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Text(
                groupId == null ? S.of(context).community : group?.name ?? '',
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
