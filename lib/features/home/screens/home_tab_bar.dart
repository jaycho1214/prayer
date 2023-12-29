import 'dart:async';
import 'dart:io';

import 'package:app_links/app_links.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer/constants/dio.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/features/common/screens/error_screen.dart';
import 'package:prayer/features/home/screens/group_prayers_screen.dart';
import 'package:prayer/features/home/widgets/home_tab_nav_button.dart';
import 'package:prayer/features/user/screens/user_screen.dart';
import 'package:prayer/features/home/screens/home_screen.dart';
import 'package:prayer/features/common/widgets/buttons/fab.dart';
import 'package:prayer/features/group/widgets/forms/group_picker.dart';
import 'package:prayer/features/common/widgets/notification_bar.dart';
import 'package:prayer/features/auth/providers/auth_provider.dart';
import 'package:prayer/features/auth/providers/auth_state.dart';
import 'package:prayer/utils/app_link.dart';

class HomeTabBar extends HookConsumerWidget {
  const HomeTabBar({super.key});

  handleNotification(BuildContext context, RemoteMessage? message) {
    if (message == null) {
      return;
    }
    final data = message.data;
    if (data['prayerId'] != null) {
      context.push('/prayers/${data["prayerId"]}');
    } else if (data['corporateId'] != null) {
      context.push('/prayers/corporateId/${data["corporateId"]}');
    } else if (data['groupId'] != null) {
      context.push('/groups/${data["groupId"]}');
    } else if (data['userId'] != null) {
      context.push(Uri(path: '/users', queryParameters: {'uid': data['userId']})
          .toString());
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = useState(0);
    final authState = ref.watch(authNotifierProvider);
    final authStateValue = ref.watch(authNotifierProvider).valueOrNull;
    useAutomaticKeepAlive(wantKeepAlive: authState is AuthStateSignedUp);

    final updateFcmToken = useCallback(() async {
      try {
        final permission = await FirebaseMessaging.instance
            .requestPermission(provisional: false);
        talker.debug(
            generateLogMessage("[Notification] Permission updated", data: {
          "status": permission.authorizationStatus.toString(),
        }));
        final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
        if (Platform.isIOS && apnsToken != null || Platform.isAndroid) {
          final fcmToken = await FirebaseMessaging.instance.getToken();
          if (fcmToken != null) {
            talker.debug(generateLogMessage(
                "[Notification] Fcm Token Refreshed",
                data: {"fcmToken": fcmToken}));
            await dio.post('/v1/users/fcmToken', data: {'value': fcmToken});
            talker.good('[Notification] Fcm Token Updated');
          }
        }
      } catch (e, st) {
        talker.handle(e, st, "[Notification] Failed to update");
      }
    }, []);

    useEffect(() {
      List<StreamSubscription<dynamic>> subscriptions = [];
      subscriptions.add(FirebaseMessaging.onMessage.listen((initialMessage) {
        if (initialMessage.notification?.body != null) {
          NotificationSnackBar.show(
            context,
            message: initialMessage.notification!.body!,
            onTap: () => handleNotification(context, initialMessage),
          );
        }
      }));
      subscriptions.add(FirebaseMessaging.onMessageOpenedApp.listen(
          (initialMessage) => handleNotification(context, initialMessage)));
      subscriptions.add(AppLinks()
          .allUriLinkStream
          .listen((uri) => handleAppLink(context, uri)));
      return () {
        subscriptions.forEach((subscription) => subscription.cancel());
      };
    }, []);

    useEffect(() {
      AppLinks().getInitialAppLink().then((uri) {
        if (uri == null) {
          return;
        }
        handleAppLink(context, uri);
      });
      updateFcmToken();
      FirebaseMessaging.instance.getInitialMessage().then(
          (initialMessage) => handleNotification(context, initialMessage));
      return () => null;
    }, []);

    return Scaffold(
      backgroundColor: MyTheme.surface,
      body: authState.hasError || !(authState.valueOrNull is AuthStateSignedUp)
          ? ErrorScreen()
          : Stack(
              children: [
                IndexedStack(
                  index: index.value,
                  children: [
                    HomeScreen(),
                    GroupPrayersScreen(),
                    UserScreen(
                      uid: FirebaseAuth.instance.currentUser!.uid,
                      canPop: false,
                    ),
                  ],
                ),
                FAB(
                  onTap: () async {
                    if (index.value == 1) {
                      final groupId = await GroupPicker.show(context);
                      if (groupId != null) {
                        context.push(Uri(
                          path: '/form/prayer',
                          queryParameters: {
                            'groupId': groupId == '' ? null : groupId
                          },
                        ).toString());
                      }
                    } else {
                      context.push('/form/prayer');
                    }
                  },
                ),
              ],
            ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: MyTheme.surface,
          border: Border(
            top: BorderSide(
              width: 0.5,
              color: MyTheme.outline,
            ),
          ),
        ),
        width: double.infinity,
        height: 50 + MediaQuery.of(context).padding.bottom,
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeTabNavButton(
                onTap: () => index.value = 0,
                focused: index.value == 0,
                focusedIcon: FontAwesomeIcons.houseChimneyHeart,
                unfocusedIcon: FontAwesomeIcons.lightHouseChimneyHeart,
              ),
              HomeTabNavButton(
                onTap: () => index.value = 1,
                focused: index.value == 1,
                focusedIcon: FontAwesomeIcons.solidUserGroupSimple,
                unfocusedIcon: FontAwesomeIcons.userGroupSimple,
              ),
              HomeTabNavProfileButton(
                onTap: () => index.value = 2,
                profile: authStateValue?.maybeWhen(
                  orElse: () => null,
                  signedUp: (user) => user.profile,
                ),
                focused: index.value == 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
