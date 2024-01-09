import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prayer/features/common/widgets/buttons/large_icon_button.dart';
import 'package:prayer/generated/l10n.dart';

class ConfirmPrayWithNameForm extends StatelessWidget {
  const ConfirmPrayWithNameForm({
    super.key,
    this.groupId,
  });

  final String? groupId;

  static Future<bool?> show(BuildContext context, {String? groupId}) {
    return showModalBottomSheet<bool>(
        elevation: 0,
        context: context,
        builder: (context) {
          return ConfirmPrayWithNameForm(groupId: groupId);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        20,
        20,
        20,
        MediaQuery.of(context).padding.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            S.of(context).prayWithName,
            style: Theme.of(context).textTheme.displaySmall,
            maxLines: 1,
            overflow: TextOverflow.fade,
          ),
          const SizedBox(height: 10),
          Text(
            groupId == null
                ? S.of(context).alertPrayWithName
                : S.of(context).alertPrayWithNameGroup,
            style: Theme.of(context).textTheme.labelMedium,
            maxLines: 10,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: LargeIconButton(
                  icon: FontAwesomeIcons.xmark,
                  onTap: () => Navigator.of(context).pop(false),
                ),
              ),
              const SizedBox(width: 10),
              LargeIconButton(
                destructive: true,
                icon: FontAwesomeIcons.lightPaperPlane,
                onTap: () => Navigator.of(context).pop(true),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
