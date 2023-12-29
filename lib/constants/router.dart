import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer/constants/mixpanel.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/features/auth/screens/login_screen.dart';
import 'package:prayer/features/auth/screens/signup_screen.dart';
import 'package:prayer/features/settings/screens/account_settings_screen.dart';
import 'package:prayer/features/settings/screens/donate_screen.dart';
import 'package:prayer/features/settings/screens/settings_screen.dart';
import 'package:prayer/features/corporate_prayer/screens/corporate_prayer_form.dart';
import 'package:prayer/features/group/screens/group_form.dart';
import 'package:prayer/features/prayer/screens/prayer_form.dart';
import 'package:prayer/features/report/screens/report_form.dart';
import 'package:prayer/features/user/screens/user_form.dart';
import 'package:prayer/features/group/screens/group_members_screen.dart';
import 'package:prayer/features/group/screens/group_screen.dart';
import 'package:prayer/features/home/screens/search_screen.dart';
import 'package:prayer/features/user/screens/user_screen.dart';
import 'package:prayer/features/home/screens/home_tab_bar.dart';
import 'package:prayer/features/common/screens/image_gallery_screen.dart';
import 'package:prayer/features/settings/notifications/screens/notifications_screen.dart';
import 'package:prayer/features/corporate_prayer/screens/corporate_prayer_screen.dart';
import 'package:prayer/features/prayer/screens/prayer_screen.dart';
import 'package:prayer/features/user/screens/user_follows_screen.dart';
import 'package:prayer/features/auth/providers/auth_provider.dart';
import 'package:prayer/features/auth/providers/auth_state.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';

class AppRouter {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static final routerProvider = Provider((ref) {
    final authState = ref.watch(authNotifierProvider);
    return GoRouter(
      navigatorKey: navigatorKey,
      initialLocation: switch (
          GetIt.I<SharedPreferences>().getInt('auth.signInStatus') ?? 0) {
        2 => '/',
        _ => '/auth/signIn',
      },
      observers: [
        MixpanelNavigatorObserver(),
        SentryNavigatorObserver(),
        TalkerRouteObserver(talker),
      ],
      redirect: (context, state) {
        if (authState.isLoading) {
          return null;
        }
        if (authState.hasError) {
          return '/';
        }
        if (authState.value is AuthStateSignedIn) {
          return '/auth/signUp';
        } else if (authState.value is AuthStateSignedUp) {
          return null;
        }
        return '/auth/signIn';
      },
      routes: routes,
    );
  });

  static final List<RouteBase> routes = [
    // AUTH
    GoRoute(
      path: '/auth/signIn',
      builder: (context, state) => LoginScreen(
        needSignOut:
            (state.extra as Map<String, bool>?)?['needSignOut'] ?? false,
      ),
    ),
    GoRoute(
      path: '/auth/signUp',
      builder: (context, state) => const SignUpScreen(),
    ),

    // HOME
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeTabBar(),
      routes: [
        //REPORT
        GoRoute(
          path: 'report',
          builder: (context, state) => ReportScreen(
            userId: state.uri.queryParameters['userId'],
            prayId: state.uri.queryParameters['prayId'],
            groupId: state.uri.queryParameters['groupId'],
            prayerId: state.uri.queryParameters['prayerId'],
          ),
        ),

        //SEARCH
        GoRoute(
          path: 'search',
          builder: (context, state) => SearchScreen(
            initialPage: state.uri.queryParameters['type'] == 'user'
                ? SearchScreenInitialPage.user
                : SearchScreenInitialPage.group,
          ),
        ),

        //NOTIFICATONS
        GoRoute(
          path: 'notifications',
          builder: (context, state) => const NotificationsScreen(),
        ),

        // USER
        GoRoute(
          path: 'users',
          builder: (context, state) => UserScreen(
            uid: state.uri.queryParameters['uid'],
            username: state.uri.queryParameters['username'],
          ),
          routes: [
            GoRoute(
              path: ':uid/followers',
              builder: (context, state) => UsersFollowScreen(
                uid: state.pathParameters['uid']!,
                initialScreen: UsersFollowScreenPage.followers,
              ),
            ),
            GoRoute(
              path: ':uid/followings',
              builder: (context, state) => UsersFollowScreen(
                uid: state.pathParameters['uid']!,
                initialScreen: UsersFollowScreenPage.followings,
              ),
            ),
          ],
        ),

        // GROUP
        GoRoute(
          path: 'groups/:groupId',
          builder: (context, state) => GroupScreen(
            groupId: state.pathParameters['groupId']!,
          ),
          routes: [
            GoRoute(
              path: 'members',
              builder: (context, state) => GroupMembersScreen(
                groupId: state.pathParameters['groupId']!,
              ),
            ),
          ],
        ),

        // PRAYER
        GoRoute(
          path: 'prayers/:prayerId',
          builder: (context, state) => PrayerScreen(
            prayerId: state.pathParameters['prayerId']!,
          ),
        ),
        GoRoute(
          path: 'prayers/corporate/:prayerId',
          builder: (context, state) => CorporatePrayerScreen(
            prayerId: state.pathParameters['prayerId']!,
          ),
        ),

        // FORMS
        GoRoute(
          path: 'form/user',
          builder: (context, state) => const UserFormScreen(),
        ),
        GoRoute(
          path: 'form/group',
          builder: (context, state) => const GroupFormScreen(),
        ),
        GoRoute(
          path: 'form/corporate',
          builder: (context, state) => CorporatePrayerForm(
            groupId: state.uri.queryParameters['groupId']!,
          ),
        ),
        GoRoute(
          path: 'form/prayer',
          pageBuilder: (context, state) => CustomTransitionPage(
            child: PrayerFormScreen(
              groupId: state.uri.queryParameters['groupId'],
              corporateId: state.uri.queryParameters['corporateId'],
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    CupertinoFullscreenDialogTransition(
              primaryRouteAnimation: animation,
              secondaryRouteAnimation: secondaryAnimation,
              child: child,
              linearTransition: true,
            ),
          ),
        ),
        // SETTINGS
        GoRoute(
          path: 'settings',
          builder: (context, state) => const SettingsScreen(),
          routes: [
            GoRoute(
              path: 'account',
              builder: (context, state) => const AccountSettingsScreen(),
            ),
            GoRoute(
              path: 'donate',
              builder: (context, state) => const DonateScreen(),
            ),
          ],
        ),

        // Image
        GoRoute(
          path: 'image',
          builder: (context, state) =>
              ImageGalleryScreen(url: state.uri.queryParameters['imageUrl']!),
        )
      ],
    ),
  ];
}
