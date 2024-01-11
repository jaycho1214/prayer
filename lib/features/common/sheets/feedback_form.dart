import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:prayer/constants/dio.dart';
import 'package:prayer/constants/mixpanel.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/features/common/widgets/buttons/text_button.dart';
import 'package:prayer/features/common/widgets/notification_bar.dart';
import 'package:prayer/i18n/strings.g.dart';

class FeedbackForm extends HookWidget {
  const FeedbackForm({super.key});

  static Future<String?> show(BuildContext context) {
    return showModalBottomSheet<String>(
        elevation: 0,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return FeedbackForm();
        });
  }

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    final loading = useState(false);
    final onTap = useCallback(() async {
      try {
        if (controller.text.trim().isEmpty) {
          context.pop();
          return;
        }
        loading.value = true;
        await dio.post('/v1/users/feedback', data: {'value': controller.text});
        mixpanel
            .track("Feedback Sent", properties: {'feedback': controller.text});
        context.pop();
        NotificationSnackBar.show(context, message: t.feedback.alert.sent);
      } catch (e, st) {
        talker.handle(e, st, "[Feedback] Failed to send a feedback");
      } finally {
        loading.value = false;
      }
    }, []);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
          20, 20, 20, 20 + MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PrimaryTextButton(
                  text: t.general.cancel,
                  onTap: () => context.pop(null),
                ),
                loading.value
                    ? CircularProgressIndicator.adaptive()
                    : PrimaryTextButton(
                        text: t.general.done,
                        onTap: onTap,
                      ),
              ],
            ),
          ),
          TextField(
            controller: controller,
            autofocus: true,
            decoration: InputDecoration.collapsed(
              hintText: t.feedback.form.placeholder,
              hintStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).disabledColor,
              ),
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
