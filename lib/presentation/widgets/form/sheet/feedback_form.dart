import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/presentation/widgets/button/text_button.dart';

class FeedbackForm extends HookWidget {
  const FeedbackForm({super.key});

  static Future<String?> show(BuildContext context) {
    return showModalBottomSheet<String>(
        elevation: 0,
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.white.withAlpha(15),
        builder: (context) {
          return FeedbackForm();
        });
  }

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();

    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).viewInsets.bottom + 300,
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
                text: S.of(context).cancel,
                onTap: () => context.pop(null),
              ),
              PrimaryTextButton(
                text: S.of(context).done,
                onTap: () => context.pop(controller.text),
              ),
            ],
          ),
          const SizedBox(height: 10),
          TextField(
            controller: controller,
            autofocus: true,
            decoration: InputDecoration.collapsed(
              hintText: S.of(context).sendFeedback,
              hintStyle: TextStyle(fontWeight: FontWeight.bold),
            ),
            maxLength: 300,
            minLines: 7,
            maxLines: 7,
          ),
          const SizedBox(height: 20),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
