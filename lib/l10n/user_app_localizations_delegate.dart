import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/l10n/app_localizations.dart';

/// Loads [AppLocalizations] for [appLocale] while [MaterialApp.locale] may be a
/// different "framework" locale (e.g. `ru` when the user picks Karakalpak `kaa`).
class UserAppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  UserAppLocalizationsDelegate(this.appLocale);

  final Locale appLocale;

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(
      lookupAppLocalizations(appLocale),
    );
  }

  @override
  bool shouldReload(covariant UserAppLocalizationsDelegate old) =>
      old.appLocale != appLocale;
}
