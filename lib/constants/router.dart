import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:prayer/bloc/auth/authentication_bloc.dart';
import 'package:prayer/bloc/auth/authentication_state.dart';
import 'package:prayer/bloc/group/group_bloc.dart';
import 'package:prayer/presentation/screens/auth/login_screen.dart';
import 'package:prayer/presentation/screens/auth/signup_screen.dart';
import 'package:prayer/presentation/screens/form/corporate_prayer_form.dart';
import 'package:prayer/presentation/screens/form/group_form.dart';
import 'package:prayer/presentation/screens/form/prayer_form.dart';
import 'package:prayer/presentation/screens/form/user_form.dart';
import 'package:prayer/presentation/screens/group/group_members_screen.dart';
import 'package:prayer/presentation/screens/group/group_screen.dart';
import 'package:prayer/presentation/screens/home/user_screen.dart';
import 'package:prayer/presentation/screens/home_tab_bar.dart';
import 'package:prayer/presentation/screens/prayers/corporate_prayer_screen.dart';
import 'package:prayer/presentation/screens/prayers/prayer_screen.dart';
import 'package:prayer/presentation/screens/settings_screen.dart';
import 'package:prayer/presentation/screens/users/user_follows_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation:
        FirebaseAuth.instance.currentUser != null ? '/' : '/auth/signIn',
    redirect: (context, state) {
      final state = BlocProvider.of<AuthenticationBloc>(context).state;
      if (state is AuthenticationStateSignedIn) {
        return '/auth/signUp';
      } else if (state is AuthenticationStateSignedUp) {
        return null;
      }
      return '/auth/signIn';
    },
    routes: [
      // AUTH
      GoRoute(
        path: '/auth/signIn',
        builder: (context, state) => const LoginScreen(),
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
                builder: (context, state) => BlocProvider.value(
                  value: state.extra! as GroupBloc,
                  child: GroupMembersScreen(
                    groupId: state.pathParameters['groupId']!,
                  ),
                ),
              )
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
            builder: (context, state) => PrayerFormScreen(
              groupId: state.uri.queryParameters['groupId'],
              corporateId: state.uri.queryParameters['corporateId'],
            ),
          ),

          // SETTINGS
          GoRoute(
            path: 'settings',
            builder: (context, state) => const SettingsScreen(),
          ),
        ],
      ),
    ],
  );
}
