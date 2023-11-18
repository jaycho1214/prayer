import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class SwitchForm extends StatelessWidget {
  const SwitchForm({
    super.key,
    required this.name,
    required this.label,
  });

  final String name;
  final String label;

  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
        name: name,
        builder: (FormFieldState<bool> field) {
          return Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              PlatformSwitch(
                value: field.value ?? false,
                onChanged: field.didChange,
              ),
            ],
          );
        });
  }
}
