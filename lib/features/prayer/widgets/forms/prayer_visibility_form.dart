import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';

class PrayerVisibilityForm extends StatelessWidget {
  const PrayerVisibilityForm({
    super.key,
    required this.anonymous,
  });

  final bool anonymous;

  static Future<bool?> show(
    BuildContext context, {
    required bool anonymous,
  }) {
    return showModalBottomSheet<bool>(
        elevation: 0,
        context: context,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.white.withAlpha(15),
        builder: (context) {
          return PrayerVisibilityForm(
            anonymous: anonymous,
          );
        });
  }

  Widget buildRow(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required bool value,
  }) {
    return ShrinkingButton(
      onTap: () {
        context.pop(value);
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 40,
              child: FaIcon(
                icon,
                size: 30,
                color: MyTheme.onPrimary,
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
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                      ),
                      if (value == anonymous)
                        Container(
                          margin: const EdgeInsets.only(left: 5),
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green,
                          ),
                          child: FaIcon(
                            FontAwesomeIcons.check,
                            size: 12,
                            color: MyTheme.onPrimary,
                          ),
                        ),
                    ],
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      color: MyTheme.placeholderText,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 400,
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: MyTheme.sheetSurface,
        ),
        child: Column(
          children: [
            Text(
              S.of(context).titleHowToShareYourPrayer,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            buildRow(
              context,
              icon: FontAwesomeIcons.lightUser,
              title: S.of(context).withName,
              description: S.of(context).titleWithName,
              value: false,
            ),
            Divider(color: MyTheme.outline),
            buildRow(
              context,
              icon: FontAwesomeIcons.lightUserSlash,
              title: S.of(context).anonymously,
              description: S.of(context).titleAnonymously,
              value: true,
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom),
          ],
        ),
      ),
    );
  }
}
