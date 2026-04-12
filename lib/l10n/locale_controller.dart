import 'package:flutter/material.dart';

/// Drives [MaterialApp.locale]. Supports Latin Uzbek, Cyrillic Uzbek, Karakalpak, Russian.
class LocaleController extends ChangeNotifier {
  static final Locale uzLatin = const Locale('uz');
  static final Locale uzCyrl =
      Locale.fromSubtags(languageCode: 'uz', scriptCode: 'Cyrl');
  static final Locale kaaLocale = const Locale('kaa');
  static final Locale ruLocale = const Locale('ru');

  /// Locales shown in the header picker (fixed order).
  static List<Locale> get pickerLocales =>
      <Locale>[uzLatin, uzCyrl, kaaLocale, ruLocale];

  Locale _locale = uzLatin;

  Locale get locale => _locale;

  /// Locale for [MaterialApp.locale] / Material & Cupertino delegates.
  /// Karakalpak (`kaa`) is not supported by Flutter framework delegates — use Russian.
  /// Cyrillic Uzbek uses Latin `uz` for tooltips, dates, etc.
  static Locale frameworkLocale(Locale appLocale) {
    if (appLocale.languageCode == 'kaa') {
      return ruLocale;
    }
    if (appLocale.languageCode == 'uz' &&
        (appLocale.scriptCode ?? '') == 'Cyrl') {
      return uzLatin;
    }
    return appLocale;
  }

  /// Same written language + script (Latin `uz` vs Cyrillic `uz` differ by scriptCode).
  static bool sameLocale(Locale a, Locale b) {
    final as = a.scriptCode ?? '';
    final bs = b.scriptCode ?? '';
    return a.languageCode == b.languageCode && as == bs;
  }

  /// Short label on the closed picker chip (fixed-width area).
  static String chipLabel(Locale locale) {
    if (locale.languageCode == 'uz' && (locale.scriptCode ?? '') == 'Cyrl') {
      return 'Ўзбекча';
    }
    if (locale.languageCode == 'uz') return "O'zbekcha";
    if (locale.languageCode == 'kaa') return 'Qaraqalpaqsha';
    if (locale.languageCode == 'ru') return 'Русский';
    return "O'zbekcha";
  }

  /// Full row label inside the opened menu.
  static String menuItemLabel(Locale locale) {
    if (locale.languageCode == 'uz' && (locale.scriptCode ?? '') == 'Cyrl') {
      return 'Ўзбекча (кирилл)';
    }
    if (locale.languageCode == 'uz') return "O'zbekcha (lotin)";
    if (locale.languageCode == 'kaa') return 'Qaraqalpaqsha';
    if (locale.languageCode == 'ru') return 'Русский';
    return "O'zbekcha (lotin)";
  }

  void setLocale(Locale locale) {
    if (sameLocale(_locale, locale)) return;
    _locale = locale;
    notifyListeners();
  }
}
