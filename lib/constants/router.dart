import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer/constants/mixpanel.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/presentation/screens/auth/login_screen.dart';
import 'package:prayer/presentation/screens/auth/signup_screen.dart';
import 'package:prayer/presentation/screens/form/corporate_prayer_form.dart';
import 'package:prayer/presentation/screens/form/group_form.dart';
import 'package:prayer/presentation/screens/form/prayer_form.dart';
import 'package:prayer/presentation/screens/form/report_form.dart';
import 'package:prayer/presentation/screens/form/user_form.dart';
import 'package:prayer/presentation/screens/group/group_members_screen.dart';
import 'package:prayer/presentation/screens/group/group_screen.dart';
import 'package:prayer/presentation/screens/home/search_screen.dart';
import 'package:prayer/presentation/screens/home/user_screen.dart';
import 'package:prayer/presentation/screens/home_tab_bar.dart';
import 'package:prayer/presentation/screens/image_gallery_screen.dart';
import 'package:prayer/presentation/screens/notifications_screen.dart';
import 'package:prayer/presentation/screens/prayers/corporate_prayer_screen.dart';
import 'package:prayer/presentation/screens/prayers/prayer_screen.dart';
import 'package:prayer/presentation/screens/settings/account_settings_screen.dart';
import 'package:prayer/presentation/screens/settings/donate_screen.dart';
import 'package:prayer/presentation/screens/settings/settings_screen.dart';
import 'package:prayer/presentation/screens/users/user_follows_screen.dart';
import 'package:prayer/providers/auth/auth_provider.dart';
import 'package:prayer/providers/auth/auth_state.dart';
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
          builder: (context, state) => const SearchScreen(),
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
              path: ':uid/follows',
              builder: (context, state) => UsersFollowScreen(
                uid: state.pathParameters['uid']!,
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
