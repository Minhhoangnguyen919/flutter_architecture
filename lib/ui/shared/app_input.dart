import 'package:develop_app_hoangnm/ui/shared/app_theme.dart';
import 'package:develop_app_hoangnm/ui/shared/colors.dart';
import 'package:flutter/material.dart';

class AppInput extends StatelessWidget {
  final String hintText;
  final Widget? prefixIcon;
  final double radius;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final double? contentPaddingHorizontal;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final bool obscureText;
  final Widget? suffixIcon;
  final bool readOnly;
  final String? label;
  final Function()? onTap;

  const AppInput({
    Key? key,
    required this.hintText,
    this.prefixIcon,
    this.radius = 30.0,
    this.controller,
    this.onChanged,
    this.contentPaddingHorizontal,
    this.validator,
    this.keyboardType,
    this.textStyle,
    this.hintStyle,
    this.obscureText = false,
    this.suffixIcon,
    this.readOnly = false,
    this.label,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(
            padding: EdgeInsets.only(
              bottom: (MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top -
                      MediaQuery.of(context).padding.bottom) *
                  0.01,
              left: (MediaQuery.of(context).size.width * 0.012),
            ),
            child: Text(
              label!,
              style: AppText.text18.copyWith(color: Colors.grey),
            ),
          ),
        TextFormField(
          style:
              textStyle ?? AppText.text20.copyWith(fontWeight: FontWeight.bold),
          onTap: onTap,
          validator: validator,
          keyboardType: keyboardType,
          obscureText: obscureText,
          controller: controller,
          onChanged: onChanged,
          readOnly: readOnly,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            isDense: true,
            hintText: hintText,
            contentPadding: EdgeInsets.symmetric(
              horizontal: contentPaddingHorizontal ??
                  MediaQuery.of(context).size.height * 0.01,
              vertical: MediaQuery.of(context).size.height * 0.01217,
            ),
            hintStyle: hintStyle ??
                AppText.text20.copyWith(color: HexColors.greyTextField),
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.black,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
        ),
      ],
    );
  }
}
