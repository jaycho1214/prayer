import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:jiffy/jiffy.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';

class DayPicker extends HookWidget {
  const DayPicker({
    super.key,
    this.initialValue,
  });

  final List<int>? initialValue;

  static Future<List<int>?> show(
    BuildContext context, {
    List<int>? initialValue,
  }) {
    return showModalBottomSheet<List<int>>(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: MyTheme.sheetSurface,
      barrierColor: Colors.white.withAlpha(15),
      builder: (context) => DayPicker(
        initialValue: initialValue,
      ),
    );
  }

  Widget _buildRow({
    required String title,
    void Function()? onTap,
    required bool value,
  }) {
    return ShrinkingButton(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          IgnorePointer(
            child: Checkbox(
              value: value,
              onChanged: (value) => null,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = useState(initialValue ?? <int>[]);
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
          ...[7, 1, 2, 3, 4, 5, 6]
              .map((index) => _buildRow(
                  title: Jiffy.now().startOf(Unit.week).add(days: index).EEEE,
                  value: state.value.indexOf(index) != -1,
                  onTap: () => state.value = state.value.indexOf(index) == -1
                      ? [...state.value, index]
                      : [...state.value..remove(index)]))
              .toList(),
          ShrinkingButton(
            onTap: () => context.pop([...state.value]),
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
