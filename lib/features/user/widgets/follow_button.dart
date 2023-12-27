import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';
import 'package:prayer/features/common/widgets/snackbar.dart';
import 'package:prayer/features/user/providers/user_provider.dart';

class FollowButton extends ConsumerWidget {
  const FollowButton({
    super.key,
    required this.uid,
    required this.followedAt,
  });

  final String? uid;
  final DateTime? followedAt;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userNotifierProvider(uid: uid));
    final blockedAt = user.valueOrNull?.blockedAt;
    final followedAt = user.valueOrNull?.followedAt;
    final colors = blockedAt != null
        ? [Colors.transparent, MyTheme.onPrimary]
        : followedAt == null
            ? [MyTheme.onPrimary, MyTheme.surface]
            : [MyTheme.surface, MyTheme.onPrimary];
    final text = blockedAt != null
        ? S.of(context).blocked
        : followedAt == null
            ? S.of(context).follow
            : S.of(context).following;

    return ShrinkingButton(
      onTap: () async {
        if (blockedAt != null) {
          try {
            await ref
                .read(userNotifierProvider(uid: uid).notifier)
                .blockUser(false);
          } catch (e, st) {
            talker.handle(e, st, "[FollowButton] Failed to block $uid");
            GlobalSnackBar.show(context,
                message: S.of(context).errorFollowUser);
          }
          return;
        }
        try {
          await ref
              .read(userNotifierProvider(uid: uid).notifier)
              .followUser(followedAt == null);
        } catch (e, st) {
          talker.handle(e, st, "[FollowButton] Failed to follow $uid");
          GlobalSnackBar.show(context, message: S.of(context).errorFollowUser);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: colors[0],
          borderRadius: BorderRadius.circular(10),
          border: blockedAt != null
              ? Border.all(color: MyTheme.error)
              : followedAt != null
                  ? Border.all(color: MyTheme.outline)
                  : null,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 15,
            color: colors[1],
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
