import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/presentation/widgets/shrinking_button.dart';

class ConfirmMenuForm extends StatelessWidget {
  const ConfirmMenuForm({
    super.key,
    required this.title,
    this.subtitle,
    required this.icon,
    this.description = const [],
  });

  final String title;
  final String? subtitle;
  final List<String> description;
  final IconData icon;

  static Future<bool?> show(
    BuildContext context, {
    required String title,
    String? subtitle,
    List<String> description = const [],
    required IconData icon,
  }) {
    return showModalBottomSheet<bool>(
        elevation: 0,
        context: context,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.white.withAlpha(15),
        builder: (context) {
          return ConfirmMenuForm(
            title: title,
            subtitle: subtitle,
            description: description,
            icon: icon,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 400,
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
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 20,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            if (subtitle != null)
              Text(
                subtitle!,
                style: TextStyle(
                  color: MyTheme.disabled,
                  fontSize: 15,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: description
                    .map((value) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(value),
                        ))
                    .toList(growable: false),
              ),
            ),
            const SizedBox(height: 20),
            Row(
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
                      width: 60,
                      height: 60,
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
                    height: 60,
                    width: 60,
                    child: Center(
                      child: Icon(
                        icon,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
