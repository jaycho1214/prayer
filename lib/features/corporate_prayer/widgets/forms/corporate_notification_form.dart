import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:jiffy/jiffy.dart';
import 'package:prayer/features/common/widgets/buttons/large_text_button.dart';
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

  Widget _buildRow(
    BuildContext context, {
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
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: disabled == true
                            ? Theme.of(context).disabledColor
                            : null),
                  ),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: disabled == true
                            ? Theme.of(context).disabledColor
                            : null),
                  ),
                ],
              ),
            ),
            AbsorbPointer(
              child: Checkbox(
                side: disabled == true
                    ? MaterialStateBorderSide.resolveWith((states) =>
                        BorderSide(color: Theme.of(context).disabledColor))
                    : null,
                value: value,
                onChanged: (value) => null,
              ),
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
      padding: EdgeInsets.fromLTRB(
          20, 20, 20, MediaQuery.of(context).padding.bottom + 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            S.of(context).corporate,
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17),
          ),
          const SizedBox(height: 10),
          _buildRow(
            context,
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
          const Divider(),
          _buildRow(
            context,
            title: S.of(context).members,
            description: S.of(context).groupNotificationSettingsAll,
            value: state.value.onPost,
            onTap: () =>
                state.value = state.value.copyWith(onPost: !state.value.onPost),
          ),
          const SizedBox(height: 20),
          LargeTextButton(
            onTap: () => context.pop(state.value.copyWith()),
            text: S.of(context).done,
          ),
        ],
      ),
    );
  }
}
