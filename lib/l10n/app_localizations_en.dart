// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'MyShop';

  @override
  String get welcome => 'Welcome';

  @override
  String get signInSubtitle => 'Sign in to your account';

  @override
  String get email => 'Email';

  @override
  String get emailHint => 'Enter your email';

  @override
  String get password => 'Password';

  @override
  String get passwordHint => 'Enter your password';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get signIn => 'Sign in';

  @override
  String get or => 'or';

  @override
  String get signInWithGoogle => 'Continue with Google';

  @override
  String get noAccount => 'Don\'t have an account? ';

  @override
  String get signUp => 'Sign up';

  @override
  String get cancel => 'Cancel';

  @override
  String get remove => 'Remove';

  @override
  String get featureComingSoon => 'This feature will be available soon.';

  @override
  String get passwordResetHint =>
      'If this were a live app, we would email you a reset link.';

  @override
  String get googleSignInComingSoon => 'Google sign-in will be available soon.';

  @override
  String get signUpComingSoon => 'Registration will be available soon.';

  @override
  String get orderPlaced => 'Your order has been placed. Thank you!';

  @override
  String get addedToCart => 'Added to cart';

  @override
  String get linkCopied => 'Product name copied to clipboard';

  @override
  String get tabShop => 'Shop';

  @override
  String get tabCategories => 'Categories';

  @override
  String get tabCart => 'Cart';

  @override
  String get tabFavorites => 'Favorites';

  @override
  String get freeShippingBanner => 'Free delivery on orders over 200,000 UZS';

  @override
  String get cityTashkent => 'Tashkent';

  @override
  String get help => 'Help';

  @override
  String get languageUzbek => 'Uzbek';

  @override
  String get languageEnglish => 'English';

  @override
  String get searchProductsHint => 'Search products or categories...';

  @override
  String get searchShopHint => 'Search products...';

  @override
  String get categoryAll => 'All';

  @override
  String get heroTitle => 'Fresh Products\nAt Your Home';

  @override
  String get heroSubtitle => 'The best quality produce — only here';

  @override
  String get heroCta => 'Start ordering';

  @override
  String get shopCategoriesTitle => 'Shop by category';

  @override
  String get shopCategoriesSubtitle =>
      'Find fresh ingredients for your kitchen';

  @override
  String get seeAll => 'See all';

  @override
  String get seeAllShort => 'All';

  @override
  String get buy => 'Buy';

  @override
  String get addToCart => 'Add to cart';

  @override
  String get subtotal => 'Subtotal';

  @override
  String get delivery => 'Delivery';

  @override
  String get free => 'Free';

  @override
  String get total => 'Total';

  @override
  String get checkout => 'Checkout';

  @override
  String get cartSummary => 'Order summary';

  @override
  String get emptyCartTitle => 'Your cart is empty';

  @override
  String get emptyCartSubtitle => 'Add products to get started';

  @override
  String get noProductsFound => 'No products found';

  @override
  String get categoryEmptyProducts =>
      'There are no products in this category yet.';

  @override
  String get emptyFavoritesTitle => 'No favorites yet';

  @override
  String get emptyFavoritesSubtitle => 'Tap the heart on products you like';

  @override
  String get removeFavoriteTitle => 'Remove favorite';

  @override
  String get removeFavoriteMessage => 'Remove this item from favorites?';

  @override
  String get logout => 'Log out';

  @override
  String get navOrders => 'My orders';

  @override
  String get navProfile => 'My details';

  @override
  String get navAddress => 'Delivery address';

  @override
  String get navPayment => 'Payment methods';

  @override
  String get navPromo => 'Promo codes';

  @override
  String get navSettings => 'Settings';

  @override
  String get navHelp => 'Help';

  @override
  String get productFresh => 'Fresh farm product';

  @override
  String get organicTitle => '100% Organic';

  @override
  String get organicSubtitle => 'From the field straight to your door';

  @override
  String get descriptionTitle => 'Description';

  @override
  String get categorySubDefault => 'Top quality products';

  @override
  String get categorySubFruit => 'Natural and vitamin-rich';

  @override
  String get categorySubBread => 'Fresh baked daily';

  @override
  String get categorySubDrink => 'Refreshing and energizing';

  @override
  String get categorySubDairy => 'Clean and quality';

  @override
  String get categorySubMeat => 'Fresh halal meat';

  @override
  String get userName => 'John Doe';

  @override
  String get userEmail => 'john@example.com';

  @override
  String get phoneNumber => '+998 71 123-45-67';

  @override
  String get productRecommendations => 'You may also like';

  @override
  String priceCurrency(String amount) {
    return '$amount UZS';
  }
}
