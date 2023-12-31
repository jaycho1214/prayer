import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';

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
                    style: const TextStyle(
                        fontSize: 12, color: MyTheme.placeholderText),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            AbsorbPointer(
              child: Checkbox(
                activeColor: MyTheme.onPrimary,
                side: MaterialStateBorderSide.resolveWith(
                  (states) => BorderSide(color: MyTheme.placeholderText),
                ),
                value: value,
                onChanged: (value) {
                  if (disabled == true) {
                    return;
                  }
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
            name: 'open',
            title: S.of(context).open,
            description: S.of(context).membershipTypeOpenDescription,
            value: state.value == 'open',
            onChanged: state.didChange,
          ),
          const SizedBox(height: 10),
          _buildRow(
            name: 'restricted',
            title: S.of(context).restricted,
            description: S.of(context).membershipTypeRestrictedDescription,
            value: state.value == 'restricted',
            onChanged: state.didChange,
          ),
          const SizedBox(height: 10),
          _buildRow(
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
              style: const TextStyle(color: MyTheme.error),
              textAlign: TextAlign.left,
            ),
          ]
        ],
      ),
    );
  }
}
