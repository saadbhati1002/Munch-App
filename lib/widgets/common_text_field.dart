import 'package:app/utility/color.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {this.alignment,
      this.width,
      this.margin,
      this.controller,
      this.focusNode,
      this.isObscureText = false,
      this.textInputAction = TextInputAction.next,
      this.maxLines,
      this.hintText,
      this.prefix,
      this.prefixConstraints,
      this.suffix,
      this.keyboardType,
      this.onChanged,
      this.suffixConstraints,
      this.validator,
      this.onTap,
      this.context,
      this.isMaxLine,
      Key? key})
      : super(key: key);

  final Alignment? alignment;

  final double? width;
  final Function(String)? onChanged;

  final EdgeInsetsGeometry? margin;

  final TextEditingController? controller;

  final FocusNode? focusNode;

  final bool? isObscureText;

  final TextInputAction? textInputAction;

  final int? maxLines;

  final String? hintText;

  final Widget? prefix;
  final Function()? onTap;

  final BoxConstraints? prefixConstraints;

  final Widget? suffix;
  final TextInputType? keyboardType;
  final BuildContext? context;
  final BoxConstraints? suffixConstraints;
  final bool? isMaxLine;

  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: _buildTextFormFieldWidget(),
          )
        : _buildTextFormFieldWidget();
  }

  _buildTextFormFieldWidget() {
    return Container(
      width: MediaQuery.of(context!).size.width,
      margin: margin,
      height: isMaxLine == true ? 180 : 45,
      child: TextField(
        onChanged: onChanged,
        cursorColor: ColorConstant.mainColor,
        keyboardType: keyboardType,
        controller: controller,
        focusNode: focusNode,
        style: const TextStyle(
          color: ColorConstant.black,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        obscureText: isObscureText!,
        textInputAction: textInputAction,
        maxLines: isMaxLine == true ? 7 : 1,
        decoration: InputDecoration(
          hintText: hintText ?? "",
          hintStyle: const TextStyle(
            color: ColorConstant.greyColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: prefix,
          prefixIconConstraints: prefixConstraints,
          suffixIcon: suffix,
          suffixIconConstraints: suffixConstraints,
          fillColor: ColorConstant.white,
          filled: true,
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: ColorConstant.greyColor),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: ColorConstant.mainColor),
          ),
          isDense: true,
          contentPadding: const EdgeInsets.all(2),
        ),
        // validator: validator,
      ),
    );
  }
}
