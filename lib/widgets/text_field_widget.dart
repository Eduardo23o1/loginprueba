import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loguinprueba/config/sizes.dart';

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final String? errorText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final TextEditingController? controller;
  final bool obscureText;
  final VoidCallback? onPressedPrefixIcon;
  final VoidCallback? onPressedSuffixIcon;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode autoValidateMode;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputType? textInputType;
  final String? initialValue;
  final FocusNode? focusNode;
  final Color? fillColor;
  final Color? foregroundColor;
  final bool autofocus;
  final int maxLines;

  const TextFieldWidget(
      {this.hintText = '',
      this.errorText,
      this.prefixIcon,
      this.suffixIcon,
      this.controller,
      this.obscureText = false,
      this.onPressedPrefixIcon,
      this.onPressedSuffixIcon,
      this.validator,
      this.autoValidateMode = AutovalidateMode.onUserInteraction,
      this.onChanged,
      this.onFieldSubmitted,
      this.textInputType,
      this.initialValue,
      this.focusNode,
      Key? key,
      this.fillColor,
      this.foregroundColor,
      this.autofocus = false,
      this.maxLines = 1})
      : super(key: key);

  Widget? buildIcon(IconData? iconData, VoidCallback? callback) {
    if (iconData != null) {
      var icon = Icon(
        iconData,
        color: foregroundColor ?? const Color(0xff1E6D20),
      );
      return callback != null
          ? IconButton(onPressed: callback, icon: icon)
          : icon;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    var prefixIconWidget = buildIcon(prefixIcon, onPressedPrefixIcon);
    var suffixIconWidget = buildIcon(suffixIcon, onPressedSuffixIcon);
    return TextFormField(
      controller: controller,
      autovalidateMode: autoValidateMode,
      onChanged: onChanged,
      style: TextStyle(
          color: foregroundColor ?? const Color(0xff1E6D20),
          fontSize: Sizes.placeholder),
      cursorColor: fillColor ?? const Color(0xff1E6D20),
      obscureText: obscureText,
      maxLines: maxLines,
      validator: validator,
      keyboardType: textInputType,
      initialValue: initialValue,
      focusNode: focusNode,
      autofocus: autofocus,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xc89fec93),
        errorText: errorText,
        contentPadding: EdgeInsets.symmetric(
            horizontal: 13, vertical: maxLines > 1 ? 10 : 0),
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(
              width: 10,
              color: fillColor ?? Color.fromARGB(255, 244, 248, 244)),
        ),
        enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: Color(0xf29fec93)),
            gapPadding: 10),
        focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: fillColor ?? const Color(0xff1E6D20)),
            gapPadding: 10),
        errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: Color(0xff97e38b)),
            gapPadding: 10),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            borderSide:
                BorderSide(color: context.theme.colorScheme.errorContainer),
            gapPadding: 10),
        errorStyle: TextStyle(color: context.theme.colorScheme.errorContainer),
        hintText: hintText,
        hintStyle: TextStyle(
            color: foregroundColor ?? const Color(0xff3A8737),
            fontSize: Sizes.placeholder),
        prefixIcon: prefixIconWidget,
        suffixIcon: suffixIconWidget,
      ),
    );
  }
}
