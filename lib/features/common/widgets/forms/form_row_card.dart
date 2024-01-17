import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';

class FormRowCard extends StatelessWidget {
  const FormRowCard({
    super.key,
    required this.title,
    this.value,
    this.errorText,
    this.onTap,
  });

  final String title;
  final String? value;
  final String? errorText;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ShrinkingButton(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (value != null)
                  Expanded(
                    child: Text(
                      value!,
                      style: Theme.of(context).textTheme.labelMedium,
                      textAlign: TextAlign.end,
                    ),
                  ),
                if (value == null)
                  FaIcon(
                    FontAwesomeIcons.chevronRight,
                    color: Theme.of(context).colorScheme.onBackground,
                    size: 15,
                  ),
              ],
            ),
            if (errorText != null)
              Text(
                errorText!,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                ),
              )
          ],
        ),
      ),
    );
  }
}
