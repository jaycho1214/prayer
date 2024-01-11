import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer/constants/mixpanel.dart';
import 'package:prayer/features/common/widgets/buttons/large_text_button.dart';

import 'package:prayer/i18n/strings.g.dart';
import 'package:prayer/features/pray/sheets/too_many_pray_sheet.dart';
import 'package:prayer/features/common/widgets/snackbar.dart';
import 'package:prayer/features/prayer/providers/prayer_provider.dart';

class PrayButton extends HookConsumerWidget {
  const PrayButton({
    super.key,
    required this.prayerId,
    this.onPrayed,
  });

  final String prayerId;
  final void Function()? onPrayed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    final errorText = useState<String?>(null);
    // final prayer = ref.watch(prayerNotifierProvider(prayerId));
    // final hasPrayed = prayer.value?.hasPrayed != null;

    final onTap = useCallback((bool silent) async {
      String value = controller.text;
      if (!silent && value.trim() == '') {
        errorText.value = t.error.fieldRequired;
        return;
      }
      errorText.value = null;
      ref.read(prayerNotifierProvider(prayerId).notifier).prayForUser(
            value: value,
            onPrayed: () {
              onPrayed?.call();
              controller.clear();
              mixpanel.track("Pray Sent");
              FocusManager.instance.primaryFocus?.unfocus();
            },
            onError: () {
              GlobalSnackBar.show(context, message: t.error.unknown);
            },
            onNeedWait: () {
              mixpanel.track("Pray Need Wait");
              TooManyPraySheet.show(context);
            },
          );
    }, []);

    return Container(
      padding: EdgeInsets.fromLTRB(
          20,
          10,
          20,
          MediaQuery.of(context).viewInsets.bottom +
              MediaQuery.of(context).padding.bottom +
              10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        border: Border(
          top: BorderSide(color: Theme.of(context).colorScheme.outline),
        ),
      ),
      child: KeyboardVisibilityBuilder(
        builder: (context, isKeyboardVisible) {
          return Column(
            children: [
              TextField(
                controller: controller,
                maxLength: 200,
                expands: false,
                minLines: 1,
                maxLines: 5,
                decoration: InputDecoration(
                  counterText: isKeyboardVisible ? null : '',
                  errorText: errorText.value,
                  isCollapsed: true,
                  isDense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: t.prayer.form.pray.placeholder,
                  fillColor: Theme.of(context).colorScheme.secondary,
                  hintStyle: TextStyle(
                    color: Theme.of(context).disabledColor,
                    fontWeight: FontWeight.normal,
                  ),
                  filled: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: isKeyboardVisible
                    ? const SizedBox()
                    : Row(
                        children: [
                          Expanded(child: Divider()),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text('or'),
                          ),
                          Expanded(child: Divider()),
                        ],
                      ),
              ),
              LargeTextButton(
                text:
                    isKeyboardVisible ? t.general.pray : t.general.praySilently,
                onTap: () => onTap(!isKeyboardVisible),
              ),
            ],
          );
        },
      ),
    );
  }
}
