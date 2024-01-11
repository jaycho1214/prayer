import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:prayer/features/common/widgets/buttons/large_icon_button.dart';
import 'package:prayer/i18n/strings.g.dart';

class TooManyPraySheet extends StatelessWidget {
  const TooManyPraySheet({
    super.key,
  });

  static Future<bool?> show(BuildContext context) {
    return showModalBottomSheet<bool>(
        elevation: 0,
        context: context,
        builder: (context) {
          return TooManyPraySheet();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(
        10,
        0,
        10,
        MediaQuery.of(context).padding.bottom,
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(
            FontAwesomeIcons.handsPraying,
            size: 20,
          ),
          const SizedBox(height: 20),
          Text(
            t.prayer.alert.needWaitToPray.title,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 20,
            ),
            maxLines: 1,
            overflow: TextOverflow.fade,
          ),
          const SizedBox(height: 20),
          Text(
            t.prayer.alert.needWaitToPray.description,
            style: Theme.of(context).textTheme.labelMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          LargeIconButton(
            icon: FontAwesomeIcons.xmark,
            onTap: () => context.pop(false),
          ),
        ],
      ),
    );
  }
}
