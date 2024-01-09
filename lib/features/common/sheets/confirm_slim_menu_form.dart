import 'package:flutter/material.dart';
import 'package:prayer/features/common/widgets/buttons/large_icon_button.dart';

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
      margin: EdgeInsets.fromLTRB(
        20,
        20,
        20,
        MediaQuery.of(context).padding.bottom + 10,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displaySmall,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (description != null)
            Text(
              description!,
              style: Theme.of(context).textTheme.labelMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          const SizedBox(height: 20),
          LargeIconButton(
            icon: icon,
            onTap: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );
  }
}
