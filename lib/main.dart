import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:grocery_app/l10n/app_localizations.dart';
import 'package:grocery_app/l10n/locale_controller.dart';
import 'package:grocery_app/l10n/user_app_localizations_delegate.dart';
import 'package:grocery_app/model/cart.dart';
import 'package:grocery_app/model/categories.dart';
import 'package:grocery_app/model/orders.dart';
import 'package:grocery_app/model/products.dart';
import 'package:grocery_app/screens/login_screen.dart';
import 'package:grocery_app/util/shopping_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  GoogleFonts.config.allowRuntimeFetching = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Categories()),
        ChangeNotifierProvider.value(value: Products()),
        ChangeNotifierProvider.value(value: Cart()),
        ChangeNotifierProvider.value(value: Orders()),
        ChangeNotifierProvider(create: (_) => LocaleController()),
      ],
      child: Consumer<LocaleController>(
        builder: (context, localeCtl, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateTitle: (_) =>
                lookupAppLocalizations(localeCtl.locale).appTitle,
            theme: buildShrineTheme(),
            locale: LocaleController.frameworkLocale(localeCtl.locale),
            localizationsDelegates: [
              UserAppLocalizationsDelegate(localeCtl.locale),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            home: const LoginUI(),
          );
        },
      ),
    );
  }
}
