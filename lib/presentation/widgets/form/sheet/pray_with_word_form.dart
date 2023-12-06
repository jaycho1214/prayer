import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/generated/l10n.dart';
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
      padding: EdgeInsets.fromLTRB(
          20, 20, 20, MediaQuery.of(context).viewInsets.bottom + 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: MyTheme.sheetSurface,
      ),
      child: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PrimaryTextButton(
                  text: S.of(context).cancel,
                  onTap: () => context.pop(null),
                ),
                PrimaryTextButton(
                  text: S.of(context).pray,
                  onTap: () => context.pop(controller.text),
                ),
              ],
            ),
          ),
          TextField(
            controller: controller,
            autofocus: true,
            decoration: InputDecoration.collapsed(
              hintText: S.of(context).amen,
              hintStyle: TextStyle(fontWeight: FontWeight.bold),
            ),
            maxLength: 200,
            minLines: 5,
            maxLines: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  S.of(context).prayWithWordFormBibleVerse,
                  style: TextStyle(
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  S.of(context).prayWithWordFormBible,
                  style: TextStyle(
                    color: MyTheme.placeholderText,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.fade,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
