import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer/constants/dio.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/features/common/screens/error_screen.dart';
import 'package:prayer/features/home/screens/group_prayers_screen.dart';
import 'package:prayer/features/user/screens/user_screen.dart';
import 'package:prayer/features/home/screens/home_screen.dart';
import 'package:prayer/features/common/widgets/buttons/fab.dart';
import 'package:prayer/features/group/widgets/forms/group_picker.dart';
import 'package:prayer/features/common/widgets/notification_bar.dart';
import 'package:prayer/features/auth/providers/auth_provider.dart';
import 'package:prayer/features/auth/providers/auth_state.dart';

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
            .requestPermission(provisional: true);
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
      return () {
        subscriptions.forEach((subscription) => subscription.cancel());
      };
    }, []);

    useEffect(() {
      updateFcmToken();
      FirebaseMessaging.instance.getInitialMessage().then(
          (initialMessage) => handleNotification(context, initialMessage));
      return () => null;
    }, []);

    return PlatformScaffold(
      backgroundColor: MyTheme.surface,
      body: authState.hasError || authState.valueOrNull is AuthStateSignedOut
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
      bottomNavBar: PlatformNavBar(
        height: 50,
        material3: (context, platform) => MaterialNavigationBarData(
          surfaceTintColor: MyTheme.surface,
          indicatorColor: MyTheme.surface,
          backgroundColor: MyTheme.surface,
        ),
        cupertino: (context, platform) => CupertinoTabBarData(
            inactiveColor: MyTheme.disabled, activeColor: MyTheme.disabled),
        currentIndex: index.value,
        itemChanged: (i) {
          index.value = i;
        },
        backgroundColor: MyTheme.surface,
        items: [
          BottomNavigationBarItem(
              backgroundColor: MyTheme.surface,
              label: '',
              icon: FaIcon(
                index.value == 0
                    ? FontAwesomeIcons.houseChimneyHeart
                    : FontAwesomeIcons.lightHouseChimneyHeart,
                size: 20,
                color: index.value == 0 ? MyTheme.onPrimary : MyTheme.disabled,
              )),
          BottomNavigationBarItem(
              label: '',
              icon: FaIcon(
                index.value == 1
                    ? FontAwesomeIcons.solidUserGroupSimple
                    : FontAwesomeIcons.userGroupSimple,
                size: 20,
                color: index.value == 1 ? MyTheme.onPrimary : MyTheme.disabled,
              )),
          BottomNavigationBarItem(
            label: '',
            icon: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color:
                      index.value == 2 ? MyTheme.onPrimary : MyTheme.disabled,
                  width: index.value == 2 ? 1 : 0.5,
                ),
                shape: BoxShape.circle,
              ),
              padding: EdgeInsets.all(authStateValue is AuthStateSignedUp
                  ? authStateValue.user.profile == null
                      ? 10
                      : 2
                  : 10),
              child: UserTabButton(
                index: index.value,
                profile: authStateValue is AuthStateSignedUp
                    ? authStateValue.user.profile
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UserTabButton extends StatelessWidget {
  const UserTabButton({
    super.key,
    this.profile,
    this.index = 0,
  });

  final String? profile;
  final int index;

  Widget _renderPlaceholder() {
    return FaIcon(
      FontAwesomeIcons.user,
      size: 15,
      color: index == 2 ? MyTheme.onPrimary : MyTheme.disabled,
    );
  }

  @override
  Widget build(BuildContext context) {
    return profile == null
        ? _renderPlaceholder()
        : CachedNetworkImage(
            width: 30,
            height: 30,
            imageUrl: profile!,
            errorWidget: (context, url, error) => Center(
              child: _renderPlaceholder(),
            ),
            imageBuilder: (context, imageProvider) => Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  )),
            ),
          );
  }
}
