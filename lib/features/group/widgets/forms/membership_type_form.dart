import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:prayer/generated/l10n.dart';
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
      validator: (value) {
        if (value != 'open' && value != 'restricted' && value != 'private') {
          return S.of(context).errorNeedMembershipType;
        }
        return null;
      },
      builder: (FormFieldState<String> state) => Column(
        children: [
          _buildRow(
            context,
            name: 'open',
            title: S.of(context).open,
            description: S.of(context).membershipTypeOpenDescription,
            value: state.value == 'open',
            onChanged: state.didChange,
          ),
          const SizedBox(height: 10),
          _buildRow(
            context,
            name: 'restricted',
            title: S.of(context).restricted,
            description: S.of(context).membershipTypeRestrictedDescription,
            value: state.value == 'restricted',
            onChanged: state.didChange,
          ),
          const SizedBox(height: 10),
          _buildRow(
            context,
            name: 'private',
            title: S.of(context).private,
            description: S.of(context).membershipTypePrivateDescription,
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
