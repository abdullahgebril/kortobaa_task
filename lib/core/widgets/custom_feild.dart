import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/core/utils/color_resources.dart';
import 'package:flutter_task/core/utils/font_manager.dart';
import 'package:flutter/services.dart';

class CustomField extends StatelessWidget {
  final TextEditingController controller;
  final String? hint;
  final String? prefixText;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final Widget? suffix;
  final Widget? prefix;
  final bool? isPassword;
  final TextStyle? hintStyle;
  final TextInputType? inputType;
  final String? Function(String?)? validator;
  final Function(String?)? onChanged;
  final Function()? onEditingComplete;
  final Function()? onTap;
  final bool? readOnly;
  final int? maxLines;
  final bool? filled;
  final Color? fillColor;
  final List<TextInputFormatter>? formatter;

  double? radius;

  CustomField(
      {required this.controller,
      this.radius,
      this.hint,
      this.prefixText,
      this.suffix,
      this.prefix,
      this.isPassword = false,
      this.inputType = TextInputType.text,
      this.validator,
      this.onChanged,
      this.onEditingComplete,
      this.onTap,
      this.readOnly = false,
      this.maxLines = 1,
      this.filled = false,
      this.fillColor = Colors.white,
      this.formatter,
      super.key,
      this.hintStyle,
      this.focusNode,
      this.nextFocus});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      autocorrect: true,
      showCursor: true,
      autofocus: true,
      cursorColor: ColorResources.orangeColor,
      focusNode: focusNode,
      maxLines: maxLines!,
      readOnly: readOnly!,
      obscureText: isPassword!,
      keyboardType: inputType,
      controller: controller,
      onFieldSubmitted: (text) => nextFocus != null
          ? FocusScope.of(context).requestFocus(nextFocus)
          : null,
      style: FontManager.getBoldStyle(
          fontSize: 16.sp, color: ColorResources.primaryColor),
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      validator: validator,
      inputFormatters: formatter,
      onTap: onTap,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 5),
          borderSide: BorderSide(color: ColorResources.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 5),
          borderSide: BorderSide(color: ColorResources.primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 5),
          borderSide: BorderSide(color: ColorResources.primaryColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 5),
          borderSide: BorderSide(color: ColorResources.orangeColor),
        ),
        hintText: hint ?? "",
        hintStyle: hintStyle ??
            FontManager.getMediumStyle(
                fontSize: 14.sp, color: ColorResources.black),
        suffixIcon: suffix,
        prefixIcon: prefix,
        prefixText: prefixText,
        errorStyle: TextStyle(
          color: ColorResources.orangeColor,
        ),
        filled: filled,
        fillColor: fillColor,
        contentPadding: EdgeInsets.symmetric(
          vertical: 15.h,
          horizontal: 10.w,
        ),
      ),
    );
  }
}
