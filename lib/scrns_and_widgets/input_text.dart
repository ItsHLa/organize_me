import 'package:flutter/material.dart';
import 'package:organize_me/constants.dart';

class InputText extends StatelessWidget {
  const InputText({
    super.key,
    this.save,
    this.keyboardType,
    this.validator,
    this.labelText,
    this.readOnly,
    this.onTap,
    this.controller,
    this.obscureText,
    this.prefixIcon,
  });

  final void Function(String?)? save;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final String? labelText;
  final bool? readOnly;
  final Function()? onTap;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        onTap: onTap,
        readOnly: readOnly ?? false,
        keyboardType: keyboardType,
        onSaved: save,
        validator: validator,
        controller: controller,
        obscureText: obscureText ?? false,
        obscuringCharacter: '*',
        decoration: InputDecoration(
          suffixIcon: prefixIcon,
          labelText: labelText,
          labelStyle: TextStyle(color: appColorTheme),
          hintStyle: TextStyle(color: appColorTheme),
          border: UnderlineInputBorder(
            // borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: appColorTheme),
          ),
          focusedBorder: UnderlineInputBorder(
            // borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: appColorTheme),
          ),
          enabledBorder: const UnderlineInputBorder(
            // borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
