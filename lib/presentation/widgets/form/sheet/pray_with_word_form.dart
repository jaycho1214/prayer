import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/presentation/widgets/button/text_button.dart';

class PrayWithWordForm extends HookWidget {
  const PrayWithWordForm({super.key, required this.prayerId});

  final String prayerId;

  static Future<String?> show(
    BuildContext context, {
    required String prayerId,
  }) {
    return showModalBottomSheet<String>(
        elevation: 0,
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.white.withAlpha(15),
        builder: (context) {
          return PrayWithWordForm(
            prayerId: prayerId,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();

    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).viewInsets.bottom + 350,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: MyTheme.sheetSurface,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PrimaryTextButton(
                text: "Cancel",
                onTap: () => context.pop(null),
              ),
              PrimaryTextButton(
                text: "Pray",
                onTap: () => context.pop(controller.text),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            "Therefore confess your sins to each other and pray for each other so that you may be healed. The prayer of a righteous person is powerful and effective.",
            style: TextStyle(
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            "- James 5:16 (NIV)",
            style: TextStyle(
              color: MyTheme.outline,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.fade,
          ),
          const SizedBox(height: 10),
          TextField(
            controller: controller,
            autofocus: true,
            decoration: InputDecoration.collapsed(
              hintText: "Amen",
              hintStyle: TextStyle(fontWeight: FontWeight.bold),
            ),
            maxLength: 200,
            minLines: 5,
            maxLines: 7,
          ),
          const SizedBox(height: 20),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
