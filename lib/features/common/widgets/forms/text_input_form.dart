import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class TextInputField extends StatelessWidget {
  const TextInputField({
    super.key,
    required this.name,
    this.labelText,
    this.hintText,
    this.decoration,
    this.minLines,
    this.maxLines,
    this.maxLength,
    this.keyboardType,
    this.suffix,
    this.onSaved,
    this.onChanged,
    this.validator,
    this.autovalidateMode,
    this.onTap,
    this.initialValue,
    this.counterText,
    this.focusNode,
    this.enabled = true,
    this.autofocus = false,
    this.scrollPadding = const EdgeInsets.all(20),
  });
  final TextInputType? keyboardType;
  final String? initialValue;
  final String? counterText;
  final String? labelText;
  final String? hintText;
  final String name;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final InputDecoration? decoration;
  final Widget? suffix;
  final AutovalidateMode? autovalidateMode;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;
  final void Function()? onTap;
  final bool enabled;
  final bool autofocus;
  final EdgeInsets scrollPadding;

  OutlineInputBorder _commonBorder({required Color color, double width = 2.0}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: color,
        width: width,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          Text(
            labelText!,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
        ],
        Stack(
          alignment: Alignment.center,
          children: [
            FormBuilderTextField(
              key: key,
              scrollPadding: scrollPadding,
              focusNode: focusNode,
              autofocus: autofocus,
              name: name,
              enabled: enabled,
              initialValue: initialValue,
              autovalidateMode: autovalidateMode,
              validator: validator,
              onChanged: onChanged,
              onSaved: onSaved,
              keyboardType: keyboardType,
              maxLength: maxLength,
              minLines: minLines,
              maxLines: maxLines,
              onTap: onTap,
              decoration: InputDecoration(
                errorMaxLines: 2,
                hintText: hintText,
                counterText: counterText,
                focusedBorder: _commonBorder(
                    color: Theme.of(context).colorScheme.onBackground),
                errorBorder:
                    _commonBorder(color: Theme.of(context).colorScheme.error),
                border: _commonBorder(
                    color: Theme.of(context).colorScheme.onBackground),
                disabledBorder:
                    _commonBorder(color: Theme.of(context).disabledColor),
                enabledBorder: _commonBorder(
                    color: Theme.of(context).disabledColor, width: 1.0),
              ),
            ),
            suffix != null
                ? Positioned(
                    right: 20,
                    top: 0,
                    bottom: 25,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: suffix!,
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ],
    );
  }
}
