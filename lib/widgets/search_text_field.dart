import 'package:app/utility/color.dart';
import 'package:flutter/material.dart';

class CustomSearchTextField extends StatelessWidget {
  const CustomSearchTextField(
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
      this.onChanged,
      this.suffixConstraints,
      this.validator,
      this.onTap,
      this.context,
      this.isMaxLine,
      this.borderRadius,
      this.keyboardType,
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
  final double? borderRadius;
  final String? hintText;

  final Widget? prefix;
  final Function()? onTap;

  final BoxConstraints? prefixConstraints;

  final Widget? suffix;
  final BuildContext? context;
  final BoxConstraints? suffixConstraints;
  final bool? isMaxLine;
  final TextInputType? keyboardType;
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
      height: isMaxLine == true ? 150 : 45,
      child: TextField(
        textInputAction:
            isMaxLine == true ? TextInputAction.newline : TextInputAction.next,
        keyboardType: keyboardType ?? TextInputType.multiline,
        onTap: onTap,

        onChanged: onChanged,
        cursorColor: ColorConstant.mainColor,
        controller: controller,
        focusNode: focusNode,
        style: const TextStyle(
          color: ColorConstant.black,
          fontSize: 14,
          fontFamily: "inter",
          fontWeight: FontWeight.w500,
        ),
        obscureText: isObscureText!,

        maxLines: isMaxLine == true ? 10 : 1,
        decoration: InputDecoration(
          hintText: hintText ?? "",
          hintStyle: TextStyle(
            color: borderRadius != null
                ? ColorConstant.black
                : ColorConstant.greyColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 25),
            borderSide: BorderSide(
              color: borderRadius == null
                  ? ColorConstant.greyColor
                  : ColorConstant.white,
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 25),
            borderSide: BorderSide(
              color: borderRadius == null
                  ? ColorConstant.greyColor
                  : ColorConstant.white,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 25),
            borderSide: BorderSide(
              color: borderRadius == null
                  ? ColorConstant.greyColor
                  : ColorConstant.white,
              width: 1,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 25),
            borderSide: BorderSide(
              color: borderRadius == null
                  ? ColorConstant.greyColor
                  : ColorConstant.white,
              width: 1,
            ),
          ),
          prefixIcon: prefix,
          prefixIconConstraints: prefixConstraints,
          suffixIcon: suffix,
          suffixIconConstraints: suffixConstraints,
          fillColor: ColorConstant.white,
          filled: true,
          isDense: true,
          contentPadding: const EdgeInsets.all(10),
        ),
        // validator: validator,
      ),
    );
  }
}
