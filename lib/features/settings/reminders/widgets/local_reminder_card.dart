import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';
import 'package:prayer/features/settings/reminders/models/local_reminder.dart';
import 'package:prayer/utils/formatter.dart';

class LocalReminderCard extends StatelessWidget {
  const LocalReminderCard({
    super.key,
    required this.reminderId,
    required this.reminder,
  });

  final int reminderId;
  final LocalReminder reminder;

  @override
  Widget build(BuildContext context) {
    return ShrinkingButton(
      onTap: () =>
          context.push('/settings/reminders/form?reminderId=$reminderId'),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reminder.title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  Text(
                    reminder.body,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(reminder.time.format(context)),
                Text(Formatter.daysToString(reminder.days)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
