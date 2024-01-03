import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';

enum PostPrayerTypePickerResponse { prayer, corporate }

class PostPrayerTypePicker extends HookWidget {
  const PostPrayerTypePicker({super.key});

  static Future<PostPrayerTypePickerResponse?> show(BuildContext context) {
    return showModalBottomSheet<PostPrayerTypePickerResponse>(
      context: context,
      useSafeArea: true,
      backgroundColor: const Color.fromARGB(0, 180, 160, 160),
      barrierColor: Colors.white.withAlpha(15),
      builder: (context) => PostPrayerTypePicker(),
    );
  }

  Widget _buildRow({
    required String title,
    void Function()? onTap,
  }) {
    return ShrinkingButton(
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          20, 20, 20, MediaQuery.of(context).padding.bottom + 10),
      decoration: BoxDecoration(
        color: MyTheme.sheetSurface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Wrap(
        direction: Axis.horizontal,
        alignment: WrapAlignment.start,
        children: [
          Center(
            child: Text(
              S.of(context).pray,
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRow(
                title: S.of(context).prayer,
                onTap: () => context.pop(PostPrayerTypePickerResponse.prayer),
              ),
              Divider(color: MyTheme.outline),
              _buildRow(
                title: S.of(context).corporatePrayer,
                onTap: () =>
                    context.pop(PostPrayerTypePickerResponse.corporate),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
