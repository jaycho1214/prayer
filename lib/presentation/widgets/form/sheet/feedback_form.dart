import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/presentation/widgets/button/text_button.dart';
import 'package:prayer/presentation/widgets/notification_bar.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

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
    final loading = useState(false);
    final onTap = useCallback(() async {
      if (controller.text.trim().isEmpty) {
        context.pop();
        return;
      }
      loading.value = true;
      Sentry.captureUserFeedback(SentryUserFeedback(
        eventId: SentryId.newId(),
        comments: controller.text,
        name: FirebaseAuth.instance.currentUser?.uid,
        email: FirebaseAuth.instance.currentUser?.email,
      )).then((_) {
        context.pop();
        NotificationSnackBar.show(context,
            message: S.of(context).alertFeedbackSent);
      }).whenComplete(() {
        loading.value = false;
      });
    }, []);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
          20, 20, 20, 20 + MediaQuery.of(context).viewInsets.bottom),
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
                loading.value
                    ? CircularProgressIndicator.adaptive()
                    : PrimaryTextButton(
                        text: S.of(context).done,
                        onTap: onTap,
                      ),
              ],
            ),
          ),
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
        ],
      ),
    );
  }
}
