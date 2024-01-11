import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/i18n/strings.g.dart';
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
        ? [Colors.transparent, Theme.of(context).colorScheme.onBackground]
        : followedAt == null
            ? [
                Theme.of(context).colorScheme.surface,
                Theme.of(context).colorScheme.onSurface
              ]
            : [
                Theme.of(context).colorScheme.inverseSurface,
                Theme.of(context).colorScheme.onInverseSurface,
              ];
    final text = blockedAt != null
        ? t.general.blocked
        : followedAt == null
            ? t.general.follow
            : t.general.following;

    return ShrinkingButton(
      onTap: () async {
        if (blockedAt != null) {
          try {
            await ref
                .read(userNotifierProvider(uid: uid).notifier)
                .blockUser(false);
          } catch (e, st) {
            talker.handle(e, st, "[FollowButton] Failed to block $uid");
            GlobalSnackBar.show(context, message: t.error.unknown);
          }
          return;
        }
        try {
          await ref
              .read(userNotifierProvider(uid: uid).notifier)
              .followUser(followedAt == null);
        } catch (e, st) {
          talker.handle(e, st, "[FollowButton] Failed to follow $uid");
          GlobalSnackBar.show(context, message: t.error.unknown);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: colors[0],
          borderRadius: BorderRadius.circular(10),
          border: blockedAt != null
              ? Border.all(color: Theme.of(context).colorScheme.error)
              : followedAt != null
                  ? Border.all(color: Theme.of(context).colorScheme.outline)
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
