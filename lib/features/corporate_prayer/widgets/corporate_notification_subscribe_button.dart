import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';
import 'package:prayer/features/corporate_prayer/providers/corporate_notification_provider.dart';
import 'package:prayer/features/corporate_prayer/providers/corporate_prayer_provider.dart';
import 'package:prayer/features/corporate_prayer/widgets/forms/corporate_notification_form.dart';

class CorporateNotificationSubscribeButton extends ConsumerWidget {
  const CorporateNotificationSubscribeButton({
    super.key,
    required this.corporateId,
  });

  final String corporateId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final corporate = ref.watch(corporatePrayerProvider(corporateId));
    final settings =
        ref.watch(corporateNotificationNotifierProvider(corporateId));
    return ShrinkingButton(
      onTap: () async {
        final response = await CorporateNotificationForm.show(
          context,
          initialValue: settings.value,
          reminder: corporate.value?.reminder,
        );
        if (response == null) {
          return;
        }
        ref
            .read(corporateNotificationNotifierProvider(corporateId).notifier)
            .updateSettings(response);
      },
      child: Container(
        alignment: Alignment.center,
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.primary,
        ),
        child: settings.valueOrNull == null || corporate.valueOrNull == null
            ? CircularProgressIndicator.adaptive(
                backgroundColor: Theme.of(context).colorScheme.onPrimary)
            : FaIcon(
                settings.value?.onReminder == true ||
                        settings.value?.onPost == true
                    ? FontAwesomeIcons.bell
                    : FontAwesomeIcons.bellSlash,
                size: 15,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
      ),
    );
  }
}
