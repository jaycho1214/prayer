import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';
import 'package:prayer/features/user/providers/user_provider.dart';
import 'package:prayer/i18n/strings.g.dart';

class PinnedLabel extends ConsumerWidget {
  const PinnedLabel({super.key, required this.pinnedBy});

  final String pinnedBy;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userNotifierProvider(uid: pinnedBy));
    return ShrinkingButton(
      onTap: () => context.push('/users?uid=$pinnedBy'),
      child: Row(
        children: [
          const SizedBox(width: 10),
          FaIcon(
            FontAwesomeIcons.mapPin,
            size: 13,
            color: Theme.of(context).textTheme.labelMedium?.color,
          ),
          const SizedBox(width: 5),
          Text.rich(
            t.general.pinnedBy(
              user: TextSpan(
                text: "${user.value?.name}",
                style: TextStyle(color: Colors.blue),
              ),
            ),
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
