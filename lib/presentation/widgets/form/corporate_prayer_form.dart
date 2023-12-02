import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/model/corporate_prayer_model.dart';
import 'package:prayer/presentation/widgets/form/sheet/corporate_prayer_picker.dart';
import 'package:prayer/presentation/widgets/shrinking_button.dart';
import 'package:prayer/repo/prayer_repository.dart';
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

class CorporatePrayerFormInner extends HookWidget {
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
  Widget build(BuildContext context) {
    final fetchFn = useMemoized(
        () => corporateId == null
            ? null
            : GetIt.I<PrayerRepository>().fetchCorporatePrayer(corporateId!),
        [corporateId]);
    final snapshot =
        useFuture(fetchFn, initialData: CorporatePrayer.placeholder);

    useEffect(() {
      if (snapshot.connectionState == ConnectionState.done &&
          snapshot.data == null) {
        onChange?.call(null);
      }
      return () => null;
    }, [snapshot]);

    return Skeletonizer(
      enabled: snapshot.connectionState == ConnectionState.waiting,
      child: ShrinkingButton(
        onTap: () async {
          final prayerId = await CorporatePrayerPicker.show(
            context,
            groupId: groupId,
          );
          onChange?.call(prayerId);
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: MyTheme.primary,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Text(
                corporateId == null
                    ? S.of(context).group
                    : snapshot.data?.title ?? '',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
              ),
              const SizedBox(width: 5),
              FaIcon(
                FontAwesomeIcons.chevronDown,
                color: MyTheme.onPrimary,
                size: 12,
              )
            ],
          ),
        ),
      ),
    );
  }
}
