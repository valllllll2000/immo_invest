import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  final String? label;
  final String? hint;
  final String? errorMessage;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final String? initialValue;
  final int maxLength;

  const CustomTextFormField({
    super.key,
    this.label,
    this.hint,
    this.errorMessage,
    this.onChanged,
    this.validator,
    this.initialValue,
    required this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final border = OutlineInputBorder(
      // borderSide: BorderSide(color: colors.primary),
      borderRadius: BorderRadius.circular(40),
    );
    return TextFormField(
      initialValue: initialValue,
      onChanged: onChanged,
      validator: validator,
      maxLength: maxLength,
      keyboardType:
          const TextInputType.numberWithOptions(signed: false, decimal: true),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]+')),
        FilteringTextInputFormatter.singleLineFormatter,
        // FilteringTextInputFormatter.digitsOnly,
      ],
      decoration: InputDecoration(
          enabledBorder: border,
          focusedBorder:
              border.copyWith(borderSide: BorderSide(color: colors.primary)),
          errorBorder: border.copyWith(
              borderSide: BorderSide(color: Colors.red.shade800)),
          focusedErrorBorder: border.copyWith(
              borderSide: BorderSide(color: Colors.red.shade800)),
          isDense: true,
          label: label != null ? Text(label!) : null,
          hintText: hint,
          focusColor: colors.primary,
          errorText: errorMessage),
    );
  }
}
