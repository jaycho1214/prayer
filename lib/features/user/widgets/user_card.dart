import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';
import 'package:prayer/features/user/widgets/user_image.dart';

class UserCard extends HookWidget {
  const UserCard({
    super.key,
    required this.uid,
    required this.name,
    required this.username,
    this.profile,
    this.onTap,
  });

  final void Function()? onTap;
  final String uid;
  final String? profile;
  final String name;
  final String username;

  @override
  Widget build(BuildContext context) {
    return ShrinkingButton(
      onTap: onTap ??
          () => context.push(
              Uri(path: '/users', queryParameters: {'uid': uid}).toString()),
      child: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Row(
            children: [
              AbsorbPointer(
                child: UserProfileImage(
                  profile: profile,
                  size: 50,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "@$username",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
