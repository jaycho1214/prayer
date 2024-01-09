import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/features/common/widgets/buttons/text_button.dart';

class PrayWithWordForm extends HookWidget {
  const PrayWithWordForm({
    super.key,
    required this.prayerId,
  });

  final String prayerId;

  static Future<String?> show(
    BuildContext context, {
    required String prayerId,
  }) {
    return showModalBottomSheet<String>(
        elevation: 0,
        context: context,
        isScrollControlled: true,
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  style: Theme.of(context).textTheme.labelSmall,
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
