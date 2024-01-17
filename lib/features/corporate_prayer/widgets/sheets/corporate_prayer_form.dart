import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer/features/corporate_prayer/providers/corporate_prayer_provider.dart';
import 'package:prayer/features/corporate_prayer/widgets/forms/corporate_prayer_picker.dart';
import 'package:prayer/i18n/strings.g.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CorporatePrayerForm extends HookWidget {
  const CorporatePrayerForm({
    super.key,
    required this.groupId,
    this.onChange,
  });

  final String groupId;
  final void Function(String?)? onChange;

  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
      name: 'corporateId',
      builder: (FormFieldState<String> field) => CorporatePrayerFormInner(
        groupId: groupId,
        corporateId: field.value,
        onChange: (prayerId) {
          field.didChange(prayerId);
          onChange?.call(prayerId);
        },
      ),
    );
  }
}

class CorporatePrayerFormInner extends ConsumerWidget {
  const CorporatePrayerFormInner({
    super.key,
    required this.groupId,
    this.corporateId,
    this.onChange,
  });

  final String groupId;
  final String? corporateId;
  final void Function(String?)? onChange;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snapshot = ref.watch(corporatePrayerProvider(corporateId));

    ref.listen(
      corporatePrayerProvider(corporateId),
      (previous, next) {
        if (next.value == null) {
          onChange?.call(null);
        }
      },
      onError: (e, st) {
        onChange?.call(null);
      },
    );

    return Skeletonizer(
      enabled: snapshot.isLoading,
      child: ShrinkingButton(
        onTap: () async {
          final prayerId = await CorporatePrayerPicker.show(
            context,
            groupId: groupId,
          );
          onChange?.call(prayerId);
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
                corporateId == null
                    ? t.general.group
                    : snapshot.valueOrNull?.title ?? '',
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
