import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_kaa.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_uz.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('kaa'),
    Locale('ru'),
    Locale('uz'),
    Locale.fromSubtags(languageCode: 'uz', scriptCode: 'Cyrl')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'MyShop'**
  String get appTitle;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @signInSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to your account'**
  String get signInSubtitle;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get emailHint;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get passwordHint;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signIn;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get or;

  /// No description provided for @signInWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get signInWithGoogle;

  /// No description provided for @noAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get noAccount;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signUp;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @featureComingSoon.
  ///
  /// In en, this message translates to:
  /// **'This feature will be available soon.'**
  String get featureComingSoon;

  /// No description provided for @passwordResetHint.
  ///
  /// In en, this message translates to:
  /// **'If this were a live app, we would email you a reset link.'**
  String get passwordResetHint;

  /// No description provided for @googleSignInComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Google sign-in will be available soon.'**
  String get googleSignInComingSoon;

  /// No description provided for @signUpComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Registration will be available soon.'**
  String get signUpComingSoon;

  /// No description provided for @orderPlaced.
  ///
  /// In en, this message translates to:
  /// **'Your order has been placed. Thank you!'**
  String get orderPlaced;

  /// No description provided for @addedToCart.
  ///
  /// In en, this message translates to:
  /// **'Added to cart'**
  String get addedToCart;

  /// No description provided for @linkCopied.
  ///
  /// In en, this message translates to:
  /// **'Product name copied to clipboard'**
  String get linkCopied;

  /// No description provided for @tabShop.
  ///
  /// In en, this message translates to:
  /// **'Shop'**
  String get tabShop;

  /// No description provided for @tabCategories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get tabCategories;

  /// No description provided for @tabCart.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get tabCart;

  /// No description provided for @tabFavorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get tabFavorites;

  /// No description provided for @freeShippingBanner.
  ///
  /// In en, this message translates to:
  /// **'Free delivery on orders over 200,000 UZS'**
  String get freeShippingBanner;

  /// No description provided for @cityTashkent.
  ///
  /// In en, this message translates to:
  /// **'Tashkent'**
  String get cityTashkent;

  /// No description provided for @help.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get help;

  /// No description provided for @languageUzbek.
  ///
  /// In en, this message translates to:
  /// **'Uzbek'**
  String get languageUzbek;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @searchProductsHint.
  ///
  /// In en, this message translates to:
  /// **'Search products or categories...'**
  String get searchProductsHint;

  /// No description provided for @searchShopHint.
  ///
  /// In en, this message translates to:
  /// **'Search products...'**
  String get searchShopHint;

  /// No description provided for @categoryAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get categoryAll;

  /// No description provided for @heroTitle.
  ///
  /// In en, this message translates to:
  /// **'Fresh Products\nAt Your Home'**
  String get heroTitle;

  /// No description provided for @heroSubtitle.
  ///
  /// In en, this message translates to:
  /// **'The best quality produce — only here'**
  String get heroSubtitle;

  /// No description provided for @heroCta.
  ///
  /// In en, this message translates to:
  /// **'Start ordering'**
  String get heroCta;

  /// No description provided for @shopCategoriesTitle.
  ///
  /// In en, this message translates to:
  /// **'Shop by category'**
  String get shopCategoriesTitle;

  /// No description provided for @shopCategoriesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Find fresh ingredients for your kitchen'**
  String get shopCategoriesSubtitle;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get seeAll;

  /// No description provided for @seeAllShort.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get seeAllShort;

  /// No description provided for @buy.
  ///
  /// In en, this message translates to:
  /// **'Buy'**
  String get buy;

  /// No description provided for @addToCart.
  ///
  /// In en, this message translates to:
  /// **'Add to cart'**
  String get addToCart;

  /// No description provided for @subtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get subtotal;

  /// No description provided for @delivery.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get delivery;

  /// No description provided for @free.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get free;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @checkout.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get checkout;

  /// No description provided for @cartSummary.
  ///
  /// In en, this message translates to:
  /// **'Order summary'**
  String get cartSummary;

  /// No description provided for @emptyCartTitle.
  ///
  /// In en, this message translates to:
  /// **'Your cart is empty'**
  String get emptyCartTitle;

  /// No description provided for @emptyCartSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add products to get started'**
  String get emptyCartSubtitle;

  /// No description provided for @noProductsFound.
  ///
  /// In en, this message translates to:
  /// **'No products found'**
  String get noProductsFound;

  /// No description provided for @categoryEmptyProducts.
  ///
  /// In en, this message translates to:
  /// **'There are no products in this category yet.'**
  String get categoryEmptyProducts;

  /// No description provided for @emptyFavoritesTitle.
  ///
  /// In en, this message translates to:
  /// **'No favorites yet'**
  String get emptyFavoritesTitle;

  /// No description provided for @emptyFavoritesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tap the heart on products you like'**
  String get emptyFavoritesSubtitle;

  /// No description provided for @removeFavoriteTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove favorite'**
  String get removeFavoriteTitle;

  /// No description provided for @removeFavoriteMessage.
  ///
  /// In en, this message translates to:
  /// **'Remove this item from favorites?'**
  String get removeFavoriteMessage;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logout;

  /// No description provided for @navOrders.
  ///
  /// In en, this message translates to:
  /// **'My orders'**
  String get navOrders;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'My details'**
  String get navProfile;

  /// No description provided for @navAddress.
  ///
  /// In en, this message translates to:
  /// **'Delivery address'**
  String get navAddress;

  /// No description provided for @navPayment.
  ///
  /// In en, this message translates to:
  /// **'Payment methods'**
  String get navPayment;

  /// No description provided for @navPromo.
  ///
  /// In en, this message translates to:
  /// **'Promo codes'**
  String get navPromo;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @navHelp.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get navHelp;

  /// No description provided for @productFresh.
  ///
  /// In en, this message translates to:
  /// **'Fresh farm product'**
  String get productFresh;

  /// No description provided for @organicTitle.
  ///
  /// In en, this message translates to:
  /// **'100% Organic'**
  String get organicTitle;

  /// No description provided for @organicSubtitle.
  ///
  /// In en, this message translates to:
  /// **'From the field straight to your door'**
  String get organicSubtitle;

  /// No description provided for @descriptionTitle.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get descriptionTitle;

  /// No description provided for @categorySubDefault.
  ///
  /// In en, this message translates to:
  /// **'Top quality products'**
  String get categorySubDefault;

  /// No description provided for @categorySubFruit.
  ///
  /// In en, this message translates to:
  /// **'Natural and vitamin-rich'**
  String get categorySubFruit;

  /// No description provided for @categorySubBread.
  ///
  /// In en, this message translates to:
  /// **'Fresh baked daily'**
  String get categorySubBread;

  /// No description provided for @categorySubDrink.
  ///
  /// In en, this message translates to:
  /// **'Refreshing and energizing'**
  String get categorySubDrink;

  /// No description provided for @categorySubDairy.
  ///
  /// In en, this message translates to:
  /// **'Clean and quality'**
  String get categorySubDairy;

  /// No description provided for @categorySubMeat.
  ///
  /// In en, this message translates to:
  /// **'Fresh halal meat'**
  String get categorySubMeat;

  /// No description provided for @userName.
  ///
  /// In en, this message translates to:
  /// **'John Doe'**
  String get userName;

  /// No description provided for @userEmail.
  ///
  /// In en, this message translates to:
  /// **'john@example.com'**
  String get userEmail;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'+998 71 123-45-67'**
  String get phoneNumber;

  /// No description provided for @productRecommendations.
  ///
  /// In en, this message translates to:
  /// **'You may also like'**
  String get productRecommendations;

  /// No description provided for @priceCurrency.
  ///
  /// In en, this message translates to:
  /// **'{amount} UZS'**
  String priceCurrency(String amount);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'kaa', 'ru', 'uz'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+script codes are specified.
  switch (locale.languageCode) {
    case 'uz':
      {
        switch (locale.scriptCode) {
          case 'Cyrl':
            return AppLocalizationsUzCyrl();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'kaa':
      return AppLocalizationsKaa();
    case 'ru':
      return AppLocalizationsRu();
    case 'uz':
      return AppLocalizationsUz();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
