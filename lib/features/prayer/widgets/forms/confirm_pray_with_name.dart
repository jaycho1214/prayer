import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';

class ConfirmPrayWithNameForm extends StatelessWidget {
  const ConfirmPrayWithNameForm({
    super.key,
  });

  static Future<bool?> show(BuildContext context) {
    return showModalBottomSheet<bool>(
        elevation: 0,
        context: context,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.white.withAlpha(15),
        builder: (context) {
          return ConfirmPrayWithNameForm();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            Text(
              S.of(context).prayWithName,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 20,
              ),
              maxLines: 1,
              overflow: TextOverflow.fade,
            ),
            Text(
              S.of(context).alertPrayWithName,
              style: TextStyle(
                color: MyTheme.placeholderText,
                fontSize: 15,
              ),
              maxLines: 10,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ShrinkingButton(
                      onTap: () => Navigator.of(context).pop(false),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        height: 50,
                        child: Icon(
                          FontAwesomeIcons.xmark,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ShrinkingButton(
                    onTap: () => Navigator.of(context).pop(true),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      height: 50,
                      width: 50,
                      child: Center(
                        child: FaIcon(
                          FontAwesomeIcons.handsPraying,
                          color: Colors.black,
                          size: 15,
                        ),
                      ),
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
}
