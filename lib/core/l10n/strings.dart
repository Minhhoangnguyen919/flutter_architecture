import 'package:develop_app_hoangnm/core/l10n/strings_impl.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'messages_all.dart';


class Strings with StringsImpl {
  static Future<Strings> load(Locale locale) {
    String name =
    locale.countryCode == null ? locale.languageCode : locale.toString();

    final localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return Strings();
    });
  }

  static Strings? of(BuildContext context) =>
      Localizations.of<Strings>(context, Strings);

  static Locale locale(BuildContext context) => Localizations.localeOf(context);
}
