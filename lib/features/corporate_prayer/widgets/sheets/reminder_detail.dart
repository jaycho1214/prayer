import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jiffy/jiffy.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/features/corporate_prayer/models/reminder/reminder_model.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';
import 'package:prayer/utils/formatter.dart';

class ReminderDetailSheet extends StatelessWidget {
  const ReminderDetailSheet({
    super.key,
    required this.reminder,
  });

  final Reminder reminder;

  static Future<void> show(
    BuildContext context, {
    required Reminder reminder,
  }) {
    return showModalBottomSheet<void>(
      elevation: 0,
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.white.withAlpha(15),
      builder: (context) => ReminderDetailSheet(reminder: reminder),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 350,
      color: Colors.transparent,
      margin: EdgeInsets.fromLTRB(
        10,
        0,
        10,
        MediaQuery.of(context).padding.bottom,
      ),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: MyTheme.sheetSurface,
        ),
        child: Column(
          children: [
            FaIcon(
              FontAwesomeIcons.bell,
              size: 20,
              color: Colors.white,
            ),
            const SizedBox(height: 20),
            Text(
              reminder.value,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 20,
              ),
              overflow: TextOverflow.fade,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Text(
                S.of(context).titleReminderNotifyOn(
                    Formatter.daysToString(reminder.days!.toList()),
                    Jiffy.parseFromDateTime(reminder.time).toLocal().jm),
                style: TextStyle(
                  color: MyTheme.outline,
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            ShrinkingButton(
              onTap: () => Navigator.of(context).pop(false),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                ),
                height: 50,
                width: double.infinity,
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.xmark,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
