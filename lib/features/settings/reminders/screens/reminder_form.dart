import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:prayer/features/common/widgets/buttons/large_text_button.dart';
import 'package:prayer/features/common/widgets/buttons/navigate_button.dart';
import 'package:prayer/features/common/widgets/forms/day_picker.dart';
import 'package:prayer/features/common/widgets/forms/form_row_card.dart';
import 'package:prayer/features/common/widgets/forms/text_input_form.dart';
import 'package:prayer/features/common/widgets/forms/time_picker.dart';
import 'package:prayer/features/settings/reminders/models/local_reminder.dart';

import 'package:prayer/i18n/strings.g.dart';
import 'package:prayer/utils/formatter.dart';

class ReminderFormScreen extends HookWidget {
  const ReminderFormScreen({
    super.key,
    this.reminderId,
  });

  final int? reminderId;

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>(), []);
    final initialValue = useMemoized(() {
      final value = Hive.box<LocalReminder>('local_reminders').get(reminderId);
      if (value != null) {
        return {
          'title': value.title,
          'body': value.body,
          'days': value.days,
          'time': value.time
        };
      }
      return {'title': 'Prayer'};
    }, []);

    return PlatformScaffold(
      appBar: PlatformAppBar(
        leading: NavigateBackButton(),
        title: Text(t.general.reminder),
        cupertino: (context, platform) => CupertinoNavigationBarData(
          backgroundColor: Theme.of(context).colorScheme.background,
        ),
      ),
      body: FormBuilder(
        key: formKey,
        initialValue: initialValue,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              TextInputField(
                name: 'title',
                labelText: t.general.title,
                maxLength: 10,
              ),
              const SizedBox(height: 10),
              TextInputField(
                validator: (value) =>
                    (value ?? '').trim() == '' ? t.error.fieldRequired : null,
                name: 'body',
                labelText: t.general.message,
                maxLength: 50,
              ),
              const SizedBox(height: 10),
              FormBuilderField(
                name: 'days',
                validator: (List<int>? value) =>
                    (value == null || value.length == 0)
                        ? t.error.fieldRequired
                        : null,
                builder: (FormFieldState<List<int>> field) {
                  return FormRowCard(
                    title: "Day",
                    onTap: () async {
                      final resp = await DayPicker.show(context,
                          initialValue: field.value);
                      if (resp == null) {
                        return;
                      }
                      field.didChange(resp);
                    },
                    errorText: field.errorText,
                    value: (field.value ?? []).length > 0
                        ? Formatter.daysToString(field.value!)
                        : null,
                  );
                },
              ),
              const SizedBox(height: 20),
              FormBuilderField(
                name: 'time',
                validator: (value) =>
                    value == null ? t.error.fieldRequired : null,
                builder: (FormFieldState<TimeOfDay> field) {
                  return FormRowCard(
                    onTap: () async {
                      final resp = await TimePicker.show(context,
                          initialValue: field.value);
                      if (resp == null) {
                        return;
                      }
                      field.didChange(resp);
                    },
                    title: "Time",
                    errorText: field.errorText,
                    value: field.value == null
                        ? null
                        : field.value!.format(context),
                  );
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  LargeTextButton(
                    text: t.general.test,
                    width: 80,
                    onTap: () {
                      final verify = formKey.currentState?.saveAndValidate();
                      if (verify == false) {
                        return;
                      }
                      final value = formKey.currentState?.value;
                      if (value == null) {
                        return;
                      }
                      FlutterLocalNotificationsPlugin().show(
                        10,
                        value['title'],
                        value['body'],
                        NotificationDetails(),
                      );
                    },
                  ),
                  const SizedBox(width: 10),
                  if (reminderId != null) ...[
                    LargeTextButton(
                      text: t.general.delete,
                      width: 80,
                      destructive: true,
                      onTap: () {
                        Hive.box<LocalReminder>('local_reminders')
                            .deleteAt(reminderId!);
                        context.pop();
                      },
                    ),
                    const SizedBox(width: 10),
                  ],
                  Expanded(
                    child: LargeTextButton(
                      text: t.general.done,
                      onTap: () async {
                        final verify = formKey.currentState?.saveAndValidate();
                        if (verify == false) {
                          return;
                        }
                        final value = formKey.currentState?.value;
                        if (value == null) {
                          return;
                        }
                        final newValue = LocalReminder(
                          title: value['title'],
                          body: value['body'],
                          days: value['days'],
                          time: value['time'],
                        );
                        final box = Hive.box<LocalReminder>('local_reminders');
                        if (reminderId != null) {
                          await box.putAt(reminderId!, newValue);
                        } else {
                          try {
                            await box.add(newValue);
                          } catch (e, st) {
                            print(e);
                            print(st);
                          }
                        }
                        context.pop();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
