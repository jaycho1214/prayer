import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';

class TooManyPraySheet extends StatelessWidget {
  const TooManyPraySheet({
    super.key,
  });

  static Future<bool?> show(BuildContext context) {
    return showModalBottomSheet<bool>(
        elevation: 0,
        context: context,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.white.withAlpha(15),
        builder: (context) {
          return TooManyPraySheet();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      color: Colors.transparent,
      margin: EdgeInsets.fromLTRB(
        10,
        0,
        10,
        MediaQuery.of(context).padding.bottom,
      ),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: MyTheme.sheetSurface,
        ),
        child: Column(
          children: [
            FaIcon(
              FontAwesomeIcons.handsPraying,
              size: 20,
              color: Colors.white,
            ),
            const SizedBox(height: 20),
            Text(
              S.of(context).titleYourPrayerHasBeenReceived,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 20,
              ),
              maxLines: 1,
              overflow: TextOverflow.fade,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Text(
                S.of(context).descriptionYourPrayerHasBeenReceived,
                style: TextStyle(
                  color: MyTheme.outline,
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            ShrinkingButton(
              onTap: () => Navigator.of(context).pop(false),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                ),
                height: 50,
                width: double.infinity,
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.xmark,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
