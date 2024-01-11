import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:prayer/i18n/strings.g.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';

class MembershipTypeForm extends StatelessWidget {
  const MembershipTypeForm({super.key});

  Widget _buildRow(
    BuildContext context, {
    required String name,
    required String title,
    required String description,
    required bool value,
    required void Function(String)? onChanged,
  }) =>
      ShrinkingButton(
        onTap: () {
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
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            AbsorbPointer(
              child: Checkbox(
                activeColor: Theme.of(context).colorScheme.primary,
                side: MaterialStateBorderSide.resolveWith(
                  (states) =>
                      BorderSide(color: Theme.of(context).disabledColor),
                ),
                value: value,
                onChanged: (value) {
                  onChanged?.call(name);
                },
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
      name: 'membershipType',
      initialValue: 'open',
      builder: (FormFieldState<String> state) => Column(
        children: [
          _buildRow(
            context,
            name: 'open',
            title: t.general.open,
            description: t.group.form.main.membershipType
                .description(context: GroupMembershipTypeContext.open),
            value: state.value == 'open',
            onChanged: state.didChange,
          ),
          const SizedBox(height: 10),
          _buildRow(
            context,
            name: 'restricted',
            title: t.general.restricted,
            description: t.group.form.main.membershipType
                .description(context: GroupMembershipTypeContext.restricted),
            value: state.value == 'restricted',
            onChanged: state.didChange,
          ),
          const SizedBox(height: 10),
          _buildRow(
            context,
            name: 'private',
            title: t.general.private,
            description: t.group.form.main.membershipType
                .description(context: GroupMembershipTypeContext.private),
            value: state.value == 'private',
            onChanged: state.didChange,
          ),
          if (state.errorText != null) ...[
            const SizedBox(height: 20),
            Text(
              state.errorText!,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
              textAlign: TextAlign.left,
            ),
          ]
        ],
      ),
    );
  }
}
