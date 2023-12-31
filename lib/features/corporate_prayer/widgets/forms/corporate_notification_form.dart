import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:jiffy/jiffy.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/features/corporate_prayer/models/corporate_prayer_notification_settings/corporate_prayer_notification_settings.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';
import 'package:prayer/features/corporate_prayer/models/reminder/reminder_model.dart';

class CorporateNotificationForm extends HookWidget {
  const CorporateNotificationForm({
    super.key,
    this.initialValue,
    this.reminder,
  });

  final Reminder? reminder;
  final CorporatePrayerNotificationSettings? initialValue;

  static Future<CorporatePrayerNotificationSettings?> show(
    BuildContext context, {
    CorporatePrayerNotificationSettings? initialValue,
    Reminder? reminder,
  }) {
    return showModalBottomSheet<CorporatePrayerNotificationSettings>(
      context: context,
      useSafeArea: true,
      backgroundColor: MyTheme.sheetSurface,
      barrierColor: Colors.white.withAlpha(15),
      builder: (context) => CorporateNotificationForm(
        initialValue: initialValue,
        reminder: reminder,
      ),
    );
  }

  String daysToString(BuildContext context, List<int> days) {
    final sortedDays = days..sort();
    if (sortedDays == [0, 6]) {
      return S.of(context).weekend;
    } else if (sortedDays == [1, 2, 3, 4, 5]) {
      return S.of(context).weekdays;
    } else if (sortedDays == [0, 1, 2, 3, 4, 5, 6]) {
      return S.of(context).everyday;
    }
    return reminder!.days!
        .map((e) => [
              S.of(context).daySun,
              S.of(context).dayMon,
              S.of(context).dayTue,
              S.of(context).dayWen,
              S.of(context).dayThu,
              S.of(context).dayFri,
              S.of(context).daySat
            ][e])
        .toList()
        .join(', ');
  }

  Widget _buildRow({
    required String title,
    required String description,
    void Function()? onTap,
    required bool value,
    bool? disabled,
  }) {
    return ShrinkingButton(
      onTap: disabled == true ? null : onTap,
      child: Container(
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: disabled == true ? MyTheme.disabled : Colors.white,
                    ),
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 12,
                      color: MyTheme.placeholderText,
                    ),
                  ),
                ],
              ),
            ),
            Checkbox(
              side: disabled == true
                  ? MaterialStateBorderSide.resolveWith(
                      (states) => BorderSide(color: MyTheme.disabled))
                  : null,
              value: value,
              onChanged: (value) => null,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = useState(initialValue ??
        CorporatePrayerNotificationSettings(onReminder: false, onPost: false));
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        color: MyTheme.sheetSurface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          Text(
            S.of(context).corporate,
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17),
          ),
          const SizedBox(height: 10),
          _buildRow(
            title: S.of(context).reminder,
            description: reminder == null
                ? S.of(context).noReminderSet
                : S.of(context).titleReminderNotifyOn(
                    daysToString(context, reminder!.days!.toList()),
                    Jiffy.parseFromDateTime(reminder!.time).toLocal().jm),
            value: state.value.onReminder,
            onTap: () => state.value =
                state.value.copyWith(onReminder: !state.value.onReminder),
            disabled: reminder == null,
          ),
          Divider(color: MyTheme.outline),
          _buildRow(
            title: S.of(context).members,
            description: S.of(context).groupNotificationSettingsAll,
            value: state.value.onPost,
            onTap: () =>
                state.value = state.value.copyWith(onPost: !state.value.onPost),
          ),
          ShrinkingButton(
            onTap: () => context.pop(state.value.copyWith()),
            child: Container(
              margin: EdgeInsets.only(
                top: 20,
                bottom: MediaQuery.of(context).padding.bottom,
              ),
              alignment: Alignment.center,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: MyTheme.onPrimary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                S.of(context).done,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
