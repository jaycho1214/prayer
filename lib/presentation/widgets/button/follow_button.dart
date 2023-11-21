import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/presentation/widgets/shrinking_button.dart';
import 'package:prayer/presentation/widgets/snackbar.dart';
import 'package:prayer/repo/user_repository.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FollowButton extends HookWidget {
  const FollowButton({
    super.key,
    required this.uid,
    required this.followedAt,
  });

  final String? uid;
  final DateTime? followedAt;

  @override
  Widget build(BuildContext context) {
    final _followedAt = useState(followedAt);
    final colors = _followedAt.value == null
        ? [MyTheme.onPrimary, MyTheme.surface]
        : [MyTheme.surface, MyTheme.onPrimary];
    final text = _followedAt.value == null ? 'Follow' : 'Followed';

    return ShrinkingButton(
      onTap: () async {
        if (uid == null) {
          return;
        }
        GetIt.I<UserRepository>()
            .followUser(uid: uid!, value: _followedAt.value == null)
            .then((value) {
          _followedAt.value = _followedAt.value == null ? DateTime.now() : null;
        }).catchError((e) {
          talker.error("Error while following $uid", e);
          GlobalSnackBar.show(context, message: "Failed to follow the user");
        });
      },
      child: Skeletonizer(
        enabled: uid == null,
        child: Skeleton.leaf(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
              color: colors[0],
              borderRadius: BorderRadius.circular(10),
              border: _followedAt.value != null
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
        ),
      ),
    );
  }
}
