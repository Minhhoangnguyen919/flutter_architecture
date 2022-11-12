import 'package:develop_app_hoangnm/core/l10n/strings_impl.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'messages_all.dart';


class Strings with StringsImpl {
  static Future<Strings> load(Locale locale) {
    String name =
    locale.countryCode == null ? locale.languageCode : locale.toString();

    final localeName = Intl.canonicalizedLocale(name);

    // 言語リソース読み込み
    return initializeMessages(localeName).then((_) {
      // デフォルト言語を設定
      Intl.defaultLocale = localeName;
      // 自身を返す
      return Strings();
    });
  }

  static Strings? of(BuildContext context) =>
      Localizations.of<Strings>(context, Strings);

  static Locale locale(BuildContext context) => Localizations.localeOf(context);
}
