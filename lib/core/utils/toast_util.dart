import 'package:develop_app_hoangnm/ui/shared/fonts.dart';
import 'package:flutter/material.dart';

class MessageUtils {
  static void showToastMessage(BuildContext context, String msg, {Color backgroundColor = Colors.red}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        elevation: 5,
        duration: const Duration(seconds: 3),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(100),
          ),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        content: Text(
          msg,
          style: TextStyle(
            color: Colors.white,
            fontSize: MediaQuery.of(context).size.height * 0.025,
            fontWeight: FontWeight.normal,
            fontFamily: Fonts.notoSansJPMedium,
          ),
        ),
      ),
    );
  }
}
