import 'package:develop_app_hoangnm/ui/shared/app_theme.dart';
import 'package:develop_app_hoangnm/ui/shared/colors.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final double? width;
  final double? height;
  final TextStyle? styleLabel;
  final Color? backgroundColor;
  final double borderRadius;

  const AppButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.width,
    this.height,
    this.backgroundColor,
    this.styleLabel,
    this.borderRadius = 30,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width,
      height: height ?? MediaQuery.of(context).size.height * 0.07,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? HexColors.white,
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(
              color: HexColors.black,
            ),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: styleLabel ?? AppText.text24.copyWith(color: HexColors.grey),
        ),
      ),
    );
  }
}
