import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/features/common/widgets/forms/inner_time_picker.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';

class TimePicker extends HookWidget {
  const TimePicker({
    super.key,
    this.initialValue,
    this.minuteInterval = 1,
  });

  final TimeOfDay? initialValue;
  final int minuteInterval;

  static Future<TimeOfDay?> show(
    BuildContext context, {
    TimeOfDay? initialValue,
    int minuteInterval = 1,
  }) {
    return showModalBottomSheet<TimeOfDay>(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: MyTheme.sheetSurface,
      barrierColor: Colors.white.withAlpha(15),
      builder: (context) => TimePicker(
        initialValue: initialValue,
        minuteInterval: minuteInterval,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = useState(initialValue ?? TimeOfDay(hour: 9, minute: 0));
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
            S.of(context).reminder,
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17),
          ),
          CupertinoTimePicker(
            initialTimerDuration:
                Duration(hours: state.value.hour, minutes: state.value.minute),
            minuteInterval: minuteInterval,
            onTimerDurationChanged: (time) {
              state.value = time.replacing();
            },
          ),
          ShrinkingButton(
            onTap: () => context.pop(state.value.replacing()),
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
