import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:prayer/features/common/widgets/buttons/large_text_button.dart';
import 'package:prayer/features/common/widgets/buttons/navigate_button.dart';
import 'package:prayer/features/group/providers/group_provider.dart';
import 'package:prayer/i18n/strings.g.dart';
import 'package:prayer/utils/formatter.dart';

enum GroupInformationScreenType { join, information }

class GroupInformationScreen extends ConsumerWidget {
  const GroupInformationScreen({
    super.key,
    required this.groupId,
    this.type = GroupInformationScreenType.join,
  });

  final String groupId;
  final GroupInformationScreenType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final group = ref.watch(groupNotifierProvider(groupId));
    return PlatformScaffold(
      iosContentPadding: true,
      appBar: PlatformAppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 30,
              child: NavigateBackButton(),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(type == GroupInformationScreenType.join
                      ? t.general.joinGroup
                      : t.general.group),
                  Text(
                    group.value?.name ?? '',
                    style: TextStyle(
                      fontSize: 10,
                      color: Theme.of(context).textTheme.labelMedium?.color,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 30),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                group.valueOrNull?.welcomeTitle ??
                    t.group.welcome.title(
                        group: group.valueOrNull?.name ?? t.general.group),
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: 5),
              Text(
                group.valueOrNull?.welcomeMessage ??
                    t.group.welcome.description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 50,
                          child: FaIcon(switch (
                              group.valueOrNull?.membershipType) {
                            'open' => FontAwesomeIcons.lockOpen,
                            _ => FontAwesomeIcons.lock
                          }),
                        ),
                        Expanded(
                          child: Text(
                            t['group.alert.detail.description.membershipType.${group.valueOrNull?.membershipType}'],
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        SizedBox(
                          width: 50,
                          child: FaIcon(FontAwesomeIcons.calendar),
                        ),
                        Expanded(
                          child: Text.rich(
                            t.group.alert.detail.description.establishedAt(
                              establishedAt: TextSpan(
                                text: Jiffy.parseFromDateTime(
                                        group.value?.createdAt ??
                                            DateTime.now())
                                    .toLocal()
                                    .yMMMd,
                                style: TextStyle(color: Colors.blue),
                              ),
                              user: TextSpan(
                                text: group.value?.admin?.name ?? '',
                                style: TextStyle(color: Colors.blue),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => context.push(
                                      '/users?uid=${group.value?.admin?.uid}'),
                              ),
                            ),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        SizedBox(
                          width: 50,
                          child: FaIcon(group.value?.reminder == null
                              ? FontAwesomeIcons.bellSlash
                              : FontAwesomeIcons.bell),
                        ),
                        Expanded(
                          child: Text.rich(
                            group.value?.reminder == null
                                ? TextSpan(
                                    text: t.group.alert.detail.prayerTime.empty)
                                : t.group.alert.detail.prayerTime.time(
                                    day: TextSpan(
                                      text: Formatter.daysToString(
                                          group.value!.reminder!.days!),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    time: TextSpan(
                                      text: Jiffy.parseFromDateTime(
                                              group.value!.reminder!.time)
                                          .toLocal()
                                          .jm,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      t.general.rules,
                      style: Theme.of(context).textTheme.displaySmall,
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                    ),
                    const SizedBox(height: 5),
                    if ((group.value?.rules?.length ?? 0) == 0)
                      Text(t.empty.groupRules.title),
                    if ((group.value?.rules?.length ?? 0) > 0) ...[
                      ...((group.value?.rules) ?? [])
                          .map((e) => Padding(
                                padding: const EdgeInsets.only(
                                    left: 30, top: 10, bottom: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      e.title,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    Text(
                                      e.description,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                              ))
                          .toList(),
                    ],
                    const SizedBox(height: 30),
                    switch (type) {
                      GroupInformationScreenType.information => LargeTextButton(
                          text: t.general.done,
                          onTap: () => context.pop(),
                        ),
                      _ => LargeTextButton(
                          text: t.general.join,
                          onTap: () => context.pop(true),
                        ),
                    }
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
