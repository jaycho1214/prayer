import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:prayer/features/settings/widgets/settings_row_card.dart';

import 'package:prayer/i18n/strings.g.dart';
import 'package:prayer/features/common/widgets/buttons/navigate_button.dart';
import 'package:prayer/features/common/sheets/confirm_menu_form.dart';
import 'package:prayer/features/common/sheets/confirm_slim_menu_form.dart';
import 'package:prayer/features/common/widgets/snackbar.dart';
import 'package:prayer/repo/user_repository.dart';

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        leading: NavigateBackButton(),
        title: Text(t.general.account),
        cupertino: (context, platform) => CupertinoNavigationBarData(
          backgroundColor: Theme.of(context).colorScheme.background,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: ListView(
          children: [
            SettingsRowCard(
              icon: FontAwesomeIcons.lockOpen,
              title: t.general.signOut,
              onTap: () async {
                final resp = await ConfirmSlimMenuForm.show(
                  context,
                  title: t.general.signOut,
                  description: t.alert.actionIrreversible,
                  icon: FontAwesomeIcons.lockOpen,
                );
                if (resp == true) {
                  while (context.canPop()) {
                    context.pop();
                  }
                  context.go('/auth/signIn', extra: {'needSignOut': true});
                }
              },
            ),
            const Divider(),
            SettingsRowCard(
              icon: FontAwesomeIcons.userSlash,
              title: t.alert.deleteAccount.title,
              onTap: () async {
                final resp = await ConfirmMenuForm.show(
                  context,
                  title: t.alert.deleteAccount.prompt,
                  icon: FontAwesomeIcons.userSlash,
                  description: t.alert.deleteAccount.rules,
                );
                if (resp == true) {
                  final confirmResp = await ConfirmSlimMenuForm.show(
                    context,
                    title: t.alert.deleteAccount.title,
                    description: t.alert.actionIrreversible,
                    icon: FontAwesomeIcons.userSlash,
                  );
                  if (confirmResp == true) {
                    GetIt.I<UserRepository>().deleteUser().then((_) {
                      FirebaseAuth.instance.signOut();
                      while (context.canPop()) {
                        context.pop();
                      }
                      context.go('/auth/signIn', extra: {'needSignOut': true});
                    }).catchError((err) {
                      if (err is DioException &&
                          err.response?.data['code'] == 'not-empty-resource') {
                        return GlobalSnackBar.show(context,
                            message: t.error.deleteUser);
                      }
                      GlobalSnackBar.show(context, message: t.error.unknown);
                    });
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
