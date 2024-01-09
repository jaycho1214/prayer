import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prayer/features/common/widgets/buttons/large_icon_button.dart';

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
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
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
          LargeIconButton(
            icon: icon,
            onTap: () => Navigator.of(context).pop(true),
            destructive: true,
          ),
          const SizedBox(height: 10),
          LargeIconButton(
            icon: FontAwesomeIcons.xmark,
            onTap: () => Navigator.of(context).pop(false),
          ),
        ],
      ),
    );
  }
}
