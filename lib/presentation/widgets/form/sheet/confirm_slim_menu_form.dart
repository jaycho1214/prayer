import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/presentation/widgets/shrinking_button.dart';

class ConfirmSlimMenuForm extends StatelessWidget {
  const ConfirmSlimMenuForm({
    super.key,
    required this.title,
    this.description,
    required this.icon,
  });

  final String title;
  final String? description;
  final IconData icon;

  static Future<bool?> show(
    BuildContext context, {
    required String title,
    required IconData icon,
    String? description,
  }) {
    return showModalBottomSheet<bool>(
        elevation: 0,
        context: context,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.white.withAlpha(15),
        builder: (context) {
          return ConfirmSlimMenuForm(
            title: title,
            description: description,
            icon: icon,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      color: Colors.transparent,
      margin: EdgeInsets.fromLTRB(
        10,
        0,
        10,
        MediaQuery.of(context).padding.bottom + 20,
      ),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: MyTheme.sheetSurface,
        ),
        child: Row(
          children: [
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                  ),
                  if (description != null)
                    Text(
                      description!,
                      style: TextStyle(
                        color: MyTheme.disabled,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                    ),
                ],
              ),
            ),
            ShrinkingButton(
              onTap: () => Navigator.of(context).pop(false),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                ),
                width: 60,
                height: 60,
                child: Icon(
                  FontAwesomeIcons.xmark,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(width: 5),
            ShrinkingButton(
              onTap: () => Navigator.of(context).pop(true),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(100),
                ),
                width: 60,
                height: 60,
                child: Center(
                  child: Icon(
                    icon,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 5),
          ],
        ),
      ),
    );
  }
}
