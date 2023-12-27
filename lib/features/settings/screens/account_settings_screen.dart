import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/features/settings/widgets/settings_row_card.dart';
import 'package:prayer/generated/l10n.dart';
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
      backgroundColor: MyTheme.surface,
      appBar: PlatformAppBar(
        leading: NavigateBackButton(),
        backgroundColor: MyTheme.surface,
        title: Text(S.of(context).account),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            SettingsRowCard(
              icon: FontAwesomeIcons.lockOpen,
              title: S.of(context).signOut,
              onTap: () async {
                final resp = await ConfirmSlimMenuForm.show(
                  context,
                  title: S.of(context).signOut,
                  description: S.of(context).alertYouCannotUndoThisAction,
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
            const Divider(color: MyTheme.disabled),
            SettingsRowCard(
              icon: FontAwesomeIcons.userSlash,
              title: S.of(context).deleteAccount,
              onTap: () async {
                final resp = await ConfirmMenuForm.show(
                  context,
                  title: S.of(context).titleDeleteAccount,
                  icon: FontAwesomeIcons.userSlash,
                  description:
                      S.of(context).descriptionDeleteAccount.split(':'),
                );
                if (resp == true) {
                  final confirmResp = await ConfirmSlimMenuForm.show(
                    context,
                    title: S.of(context).deleteAccount,
                    description: S.of(context).alertYouCannotUndoThisAction,
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
                            message: S.of(context).errorDeleteUser);
                      }
                      GlobalSnackBar.show(context,
                          message: S.of(context).errorUnknown);
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
