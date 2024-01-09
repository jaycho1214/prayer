import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';
import 'package:prayer/features/common/widgets/snackbar.dart';
import 'package:prayer/features/group/providers/group_provider.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:share_plus/share_plus.dart';

class GroupShareButton extends ConsumerWidget {
  const GroupShareButton({
    super.key,
    required this.groupId,
  });

  final String groupId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final group = ref.watch(groupNotifierProvider(groupId));
    return ShrinkingButton(
      onTap: () {
        final value = group.value;
        if (value == null) {
          return;
        }
        if (value.acceptedAt == null) {
          return GlobalSnackBar.show(
            context,
            message: S.of(context).errorMemberShare,
          );
        }
        if (value.membershipType == 'private' && value.moderator == null) {
          return GlobalSnackBar.show(
            context,
            message: S.of(context).errorModeratorShare,
          );
        }
        Share.shareUri(Uri(
          scheme: "https",
          host: "prayer.theagapefoundation.org",
          path: "i/groups/$groupId",
        ));
      },
      child: Container(
        alignment: Alignment.center,
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.primary,
        ),
        child: group.valueOrNull == null
            ? CircularProgressIndicator.adaptive()
            : FaIcon(
                FontAwesomeIcons.arrowUpFromBracket,
                size: 15,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
      ),
    );
  }
}
