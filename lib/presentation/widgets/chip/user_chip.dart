import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/presentation/widgets/shrinking_button.dart';
import 'package:prayer/presentation/widgets/user/user_image.dart';
import 'package:skeletonizer/skeletonizer.dart';

class UserChip extends StatelessWidget {
  const UserChip({
    super.key,
    this.uid,
    this.profile,
    this.name,
    this.username,
    this.anon = false,
  });

  final String? uid;
  final String? profile;
  final String? name;
  final String? username;
  final bool anon;

  @override
  Widget build(BuildContext context) {
    return Skeleton.leaf(
      child: FittedBox(
        child: ShrinkingButton(
          onTap: () {
            if (!anon && uid != null) {
              context.push(Uri(path: '/users', queryParameters: {'uid': uid})
                  .toString());
            }
          },
          child: Container(
            padding: const EdgeInsets.all(5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                UserProfileImage(
                  profile: anon ? null : profile,
                  size: 30,
                ),
                const SizedBox(width: 10),
                Text(
                  anon ? "Anonymous" : name ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                if (!anon && username != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      '@$username',
                      style: const TextStyle(
                        color: MyTheme.placeholderText,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
