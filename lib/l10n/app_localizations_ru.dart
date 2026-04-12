// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'MyShop';

  @override
  String get welcome => 'Добро пожаловать';

  @override
  String get signInSubtitle => 'Войдите в аккаунт';

  @override
  String get email => 'Email';

  @override
  String get emailHint => 'Введите email';

  @override
  String get password => 'Пароль';

  @override
  String get passwordHint => 'Введите пароль';

  @override
  String get forgotPassword => 'Забыли пароль?';

  @override
  String get signIn => 'Войти';

  @override
  String get or => 'или';

  @override
  String get signInWithGoogle => 'Войти через Google';

  @override
  String get noAccount => 'Нет аккаунта? ';

  @override
  String get signUp => 'Регистрация';

  @override
  String get cancel => 'Отмена';

  @override
  String get remove => 'Удалить';

  @override
  String get featureComingSoon => 'Эта функция скоро появится.';

  @override
  String get passwordResetHint =>
      'В реальном приложении мы отправили бы вам ссылку для сброса.';

  @override
  String get googleSignInComingSoon =>
      'Вход через Google скоро будет доступен.';

  @override
  String get signUpComingSoon => 'Регистрация скоро будет доступна.';

  @override
  String get orderPlaced => 'Заказ оформлен. Спасибо!';

  @override
  String get addedToCart => 'Добавлено в корзину';

  @override
  String get linkCopied => 'Название товара скопировано';

  @override
  String get tabShop => 'Магазин';

  @override
  String get tabCategories => 'Категории';

  @override
  String get tabCart => 'Корзина';

  @override
  String get tabFavorites => 'Избранное';

  @override
  String get freeShippingBanner =>
      'Бесплатная доставка при заказе от 200 000 сум';

  @override
  String get cityTashkent => 'Ташкент';

  @override
  String get help => 'Помощь';

  @override
  String get languageUzbek => 'Узбекский';

  @override
  String get languageEnglish => 'Английский';

  @override
  String get searchProductsHint => 'Поиск товаров или категорий...';

  @override
  String get searchShopHint => 'Поиск товаров...';

  @override
  String get categoryAll => 'Все';

  @override
  String get heroTitle => 'Свежие продукты\nУ вас дома';

  @override
  String get heroSubtitle => 'Лучшее качество — только у нас';

  @override
  String get heroCta => 'Начать заказ';

  @override
  String get shopCategoriesTitle => 'Покупки по категориям';

  @override
  String get shopCategoriesSubtitle => 'Свежие продукты для вашей кухни';

  @override
  String get seeAll => 'Смотреть все';

  @override
  String get seeAllShort => 'Все';

  @override
  String get buy => 'Купить';

  @override
  String get addToCart => 'В корзину';

  @override
  String get subtotal => 'Промежуточный итог';

  @override
  String get delivery => 'Доставка';

  @override
  String get free => 'Бесплатно';

  @override
  String get total => 'Итого';

  @override
  String get checkout => 'Оформить';

  @override
  String get cartSummary => 'Сводка заказа';

  @override
  String get emptyCartTitle => 'Корзина пуста';

  @override
  String get emptyCartSubtitle => 'Добавьте товары, чтобы начать';

  @override
  String get noProductsFound => 'Товары не найдены';

  @override
  String get categoryEmptyProducts => 'В этой категории пока нет товаров.';

  @override
  String get emptyFavoritesTitle => 'Пока нет избранного';

  @override
  String get emptyFavoritesSubtitle =>
      'Нажмите сердечко на понравившихся товарах';

  @override
  String get removeFavoriteTitle => 'Удалить из избранного';

  @override
  String get removeFavoriteMessage => 'Убрать этот товар из избранного?';

  @override
  String get logout => 'Выйти';

  @override
  String get navOrders => 'Мои заказы';

  @override
  String get navProfile => 'Мои данные';

  @override
  String get navAddress => 'Адрес доставки';

  @override
  String get navPayment => 'Способы оплаты';

  @override
  String get navPromo => 'Промокоды';

  @override
  String get navSettings => 'Настройки';

  @override
  String get navHelp => 'Помощь';

  @override
  String get productFresh => 'Свежий фермерский продукт';

  @override
  String get organicTitle => '100% органик';

  @override
  String get organicSubtitle => 'С поля прямо к вашей двери';

  @override
  String get descriptionTitle => 'Описание';

  @override
  String get categorySubDefault => 'Товары высшего качества';

  @override
  String get categorySubFruit => 'Натуральные и богатые витаминами';

  @override
  String get categorySubBread => 'Свежая выпечка каждый день';

  @override
  String get categorySubDrink => 'Освежающие и бодрящие';

  @override
  String get categorySubDairy => 'Чистые и качественные';

  @override
  String get categorySubMeat => 'Свежее халяльное мясо';

  @override
  String get userName => 'John Doe';

  @override
  String get userEmail => 'john@example.com';

  @override
  String get phoneNumber => '+998 71 123-45-67';

  @override
  String get productRecommendations => 'Вам может понравиться';

  @override
  String priceCurrency(String amount) {
    return '$amount сум';
  }
}
