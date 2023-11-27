import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/presentation/widgets/shrinking_button.dart';

class MembershipTypeForm extends StatelessWidget {
  const MembershipTypeForm({super.key});

  Widget _buildRow({
    required String name,
    required String title,
    required String description,
    required bool value,
    required void Function(String)? onChanged,
    bool? disabled,
  }) =>
      ShrinkingButton(
        onTap: () {
          if (disabled == true) {
            return;
          }
          onChanged?.call(name);
        },
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: disabled == true
                          ? MyTheme.disabled
                          : MyTheme.onPrimary,
                    ),
                  ),
                  Text(
                    description,
                    style:
                        const TextStyle(fontSize: 12, color: MyTheme.disabled),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Checkbox.adaptive(
                value: value,
                onChanged: (value) {
                  if (disabled == true) {
                    return;
                  }
                  onChanged?.call(name);
                }),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
      name: 'membershipType',
      initialValue: 'open',
      validator: (value) {
        if (value != 'open' && value != 'restricted' && value != 'private') {
          return 'Please choose one of the type';
        }
        return null;
      },
      builder: (FormFieldState<String> state) => Column(
        children: [
          _buildRow(
            name: 'open',
            title: 'Open',
            description:
                'Anyone can freely view, join, and/or be invited to the group.',
            value: state.value == 'open',
            onChanged: state.didChange,
          ),
          const SizedBox(height: 10),
          _buildRow(
            name: 'restricted',
            title: 'Restricted',
            description:
                'People must ask or be invited to join the group; prayers are not visible to non-members',
            value: state.value == 'restricted',
            onChanged: state.didChange,
          ),
          const SizedBox(height: 10),
          _buildRow(
            name: 'private',
            title: 'Private',
            description:
                'Similar to restricted, but it is hidden from searches and exclusively for those who are invited',
            value: state.value == 'private',
            onChanged: state.didChange,
          ),
          if (state.errorText != null) ...[
            const SizedBox(height: 20),
            Text(
              state.errorText!,
              style: const TextStyle(color: MyTheme.error),
              textAlign: TextAlign.left,
            ),
          ]
        ],
      ),
    );
  }
}
