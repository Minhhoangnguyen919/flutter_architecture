import 'package:develop_app_hoangnm/core/l10n/strings.dart';
import 'package:flutter/cupertino.dart';

class CheckValidateUtils {
  static String? validateEmail(String? value, BuildContext context) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty) {
      return Strings.of(context)!.emailRequired;
    } else if (!regex.hasMatch(value)) {
      return Strings.of(context)!.emailInvalid;
    }
    return null;
  }

  static String? validatePassword(String? value, BuildContext context) {
    // Create pattern validate
    String patternUppercase =
        ".*[A-Z].*"; // should contain at least one upper case
    String patternLowercase =
        ".*[a-z].*"; // should contain at least one lower case
    String patternDigit = ".*\\d.*"; // should contain at least one digit
    String patternSpecial =
        ".*[!@#\$%^&*+=?-].*"; // should contain at least one Special character

    // Create RegExp to check validate from pattern
    RegExp rxUppercase = RegExp(patternUppercase);
    RegExp rxLowercase = RegExp(patternLowercase);
    RegExp rxDigit = RegExp(patternDigit);
    RegExp rxSpecial = RegExp(patternSpecial);

    if (value == null || value.isEmpty) {
      return Strings.of(context)!.passwordRequired;
    }
    if (value.length < 8) {
      return Strings.of(context)!.passwordLeastLength;
    }
    if (!rxUppercase.hasMatch(value)) {
      return Strings.of(context)!.passwordUppercase;
    }
    if (!rxLowercase.hasMatch(value)) {
      return Strings.of(context)!.passwordLowerCase;
    }
    if (!rxDigit.hasMatch(value)) {
      return Strings.of(context)!.passwordDigit;
    }
    if (!rxSpecial.hasMatch(value)) {
      return Strings.of(context)!.passwordSpecial;
    }
    return null;
  }
}
