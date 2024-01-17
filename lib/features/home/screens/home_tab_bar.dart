import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer/features/common/screens/error_screen.dart';
import 'package:prayer/features/home/screens/group_prayers_screen.dart';
import 'package:prayer/features/home/widgets/home_tab_nav_button.dart';
import 'package:prayer/features/user/screens/user_screen.dart';
import 'package:prayer/features/home/screens/home_screen.dart';
import 'package:prayer/features/common/widgets/buttons/fab.dart';
import 'package:prayer/features/group/widgets/forms/group_picker.dart';
import 'package:prayer/features/auth/providers/auth_provider.dart';
import 'package:prayer/features/auth/providers/auth_state.dart';
import 'package:prayer/hook/use_app_link.dart';
import 'package:prayer/hook/use_notifications_hook.dart';

class HomeTabBar extends HookConsumerWidget {
  const HomeTabBar({super.key});

  Future<void> onTapFap(BuildContext context, {required int index}) async {
    if (index == 1) {
      final groupId = await GroupPicker.show(context);
      if (groupId != null) {
        context.push(Uri(
          path: '/form/prayer',
          queryParameters: groupId == '' ? null : {'groupId': groupId},
        ).toString());
      }
    } else {
      context.push('/form/prayer');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = useState(0);
    final authState = ref.watch(authNotifierProvider);
    final authStateValue = ref.watch(authNotifierProvider).valueOrNull;

    useAutomaticKeepAlive(wantKeepAlive: authState is AuthStateSignedUp);
    useNotifications(context);
    useAppLink(context);

    return Scaffold(
      body: authState.hasError ||
              (!authState.isLoading &&
                  !(authState.valueOrNull is AuthStateSignedUp))
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
                FAB(onTap: () => onTapFap(context, index: index.value)),
              ],
            ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              width: 0.5,
              color: Theme.of(context).colorScheme.outlineVariant,
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
