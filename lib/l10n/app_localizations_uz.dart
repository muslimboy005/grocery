// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Uzbek (`uz`).
class AppLocalizationsUz extends AppLocalizations {
  AppLocalizationsUz([String locale = 'uz']) : super(locale);

  @override
  String get appTitle => 'MyShop';

  @override
  String get welcome => 'Xush kelibsiz';

  @override
  String get signInSubtitle => 'Hisobingizga kiring';

  @override
  String get email => 'Email';

  @override
  String get emailHint => 'Emailingizni kiriting';

  @override
  String get password => 'Parol';

  @override
  String get passwordHint => 'Parolingizni kiriting';

  @override
  String get forgotPassword => 'Parolni unutdingizmi?';

  @override
  String get signIn => 'Kirish';

  @override
  String get or => 'yoki';

  @override
  String get signInWithGoogle => 'Google orqali kirish';

  @override
  String get noAccount => 'Hisobingiz yo\'qmi? ';

  @override
  String get signUp => 'Ro\'yxatdan o\'tish';

  @override
  String get cancel => 'Bekor qilish';

  @override
  String get remove => 'Olib tashlash';

  @override
  String get featureComingSoon => 'Bu funksiya tez orada qo\'shiladi.';

  @override
  String get passwordResetHint =>
      'Haqiqiy ilovada sizga tiklash havolasi yuborilar edi.';

  @override
  String get googleSignInComingSoon =>
      'Google orqali kirish tez orada ochiladi.';

  @override
  String get signUpComingSoon => 'Ro\'yxatdan o\'tish tez orada ochiladi.';

  @override
  String get orderPlaced => 'Buyurtmangiz qabul qilindi. Rahmat!';

  @override
  String get addedToCart => 'Savatga qo\'shildi';

  @override
  String get linkCopied => 'Mahsulot nomi nusxalandi';

  @override
  String get tabShop => 'Do\'kon';

  @override
  String get tabCategories => 'Turkumlar';

  @override
  String get tabCart => 'Savatcha';

  @override
  String get tabFavorites => 'Sevimlilar';

  @override
  String get freeShippingBanner =>
      'Bepul yetkazib berish — 200 000 so\'mdan yuqori buyurtmalarga';

  @override
  String get cityTashkent => 'Toshkent';

  @override
  String get help => 'Yordam';

  @override
  String get languageUzbek => 'O\'zbekcha';

  @override
  String get languageEnglish => 'Inglizcha';

  @override
  String get searchProductsHint =>
      'Mahsulotlar yoki kategoriyalarni qidiring...';

  @override
  String get searchShopHint => 'Mahsulotlarni qidiring...';

  @override
  String get categoryAll => 'Barcha';

  @override
  String get heroTitle => 'Yangi Mahsulotlar\nEndi Uyingizda';

  @override
  String get heroSubtitle => 'Eng yaxshi va sara mahsulotlar faqat bizda';

  @override
  String get heroCta => 'Zakaz berish uchun boshla';

  @override
  String get shopCategoriesTitle => 'Kategoriyalar yuzasidan xarid';

  @override
  String get shopCategoriesSubtitle =>
      'Oshxonangiz uchun yangi masalliqlar toping';

  @override
  String get seeAll => 'Barchasini ko\'rish';

  @override
  String get seeAllShort => 'Hammasi';

  @override
  String get buy => 'Sotib olish';

  @override
  String get addToCart => 'Savatga qo\'shish';

  @override
  String get subtotal => 'Oraliq jami';

  @override
  String get delivery => 'Yetkazish';

  @override
  String get free => 'Bepul';

  @override
  String get total => 'Jami';

  @override
  String get checkout => 'To\'lov qilish';

  @override
  String get cartSummary => 'Xarid xulosasi';

  @override
  String get emptyCartTitle => 'Savatchangiz bo\'sh';

  @override
  String get emptyCartSubtitle => 'Boshlash uchun mahsulot qo\'shing';

  @override
  String get noProductsFound => 'Mahsulot topilmadi';

  @override
  String get categoryEmptyProducts => 'Bu kategoriya bo\'yicha mahsulot yo\'q.';

  @override
  String get emptyFavoritesTitle => 'Hali sevimlilar yo\'q';

  @override
  String get emptyFavoritesSubtitle =>
      'Yoqtirgan mahsulotlaringizdagi yurakchani bosing';

  @override
  String get removeFavoriteTitle => 'Sevimlidan olib tashlash';

  @override
  String get removeFavoriteMessage =>
      'Bu mahsulotni sevimlilardan olib tashlaysizmi?';

  @override
  String get logout => 'Chiqish';

  @override
  String get navOrders => 'Buyurtmalarim';

  @override
  String get navProfile => 'Ma\'lumotlarim';

  @override
  String get navAddress => 'Yetkazish manzili';

  @override
  String get navPayment => 'To\'lov usullari';

  @override
  String get navPromo => 'Promo kodlar';

  @override
  String get navSettings => 'Sozlamalar';

  @override
  String get navHelp => 'Yordam';

  @override
  String get productFresh => 'Yangi va qishloq xo\'jaligi mahsuloti';

  @override
  String get organicTitle => '100% Organik';

  @override
  String get organicSubtitle => 'Daladan to\'g\'ridan-to\'g\'ri uyingizga';

  @override
  String get descriptionTitle => 'Tavsif';

  @override
  String get categorySubDefault => 'Eng sifatli mahsulotlar';

  @override
  String get categorySubFruit => 'Tabiiy va vitaminlarga boy';

  @override
  String get categorySubBread => 'Har kuni yangi';

  @override
  String get categorySubDrink => 'Sersuv va tetiklantiruvchi';

  @override
  String get categorySubDairy => 'Toza va sifatli';

  @override
  String get categorySubMeat => 'Yangi so\'yilgan halol go\'sht';

  @override
  String get userName => 'John Doe';

  @override
  String get userEmail => 'john@example.com';

  @override
  String get phoneNumber => '+998 71 123-45-67';

  @override
  String get productRecommendations => 'Sizga ham yoqishi mumkin';

  @override
  String priceCurrency(String amount) {
    return '$amount so\'m';
  }
}

/// The translations for Uzbek, using the Cyrillic script (`uz_Cyrl`).
class AppLocalizationsUzCyrl extends AppLocalizationsUz {
  AppLocalizationsUzCyrl() : super('uz_Cyrl');

  @override
  String get appTitle => 'MyShop';

  @override
  String get welcome => 'Хуш келибсиз';

  @override
  String get signInSubtitle => 'Ҳисобингизга киринг';

  @override
  String get email => 'Email';

  @override
  String get emailHint => 'Emailингизни киритинг';

  @override
  String get password => 'Парол';

  @override
  String get passwordHint => 'Паролингизни киритинг';

  @override
  String get forgotPassword => 'Паролни унутдингизми?';

  @override
  String get signIn => 'Кириш';

  @override
  String get or => 'ёки';

  @override
  String get signInWithGoogle => 'Google орқали кириш';

  @override
  String get noAccount => 'Ҳисобингиз ё\'қми? ';

  @override
  String get signUp => 'Рўйхатдан ўтиш';

  @override
  String get cancel => 'Бекор қилиш';

  @override
  String get remove => 'Олиб ташлаш';

  @override
  String get featureComingSoon => 'Бу функсия тез орада қўшилади.';

  @override
  String get passwordResetHint =>
      'Ҳақиқий иловада сизга тиклаш ҳаволаси юборилар еди.';

  @override
  String get googleSignInComingSoon => 'Google орқали кириш тез орада очилади.';

  @override
  String get signUpComingSoon => 'Рўйхатдан ўтиш тез орада очилади.';

  @override
  String get orderPlaced => 'Буюртмангиз қабул қилинди. Раҳмат!';

  @override
  String get addedToCart => 'Саватга қўшилди';

  @override
  String get linkCopied => 'Маҳсулот номи нусхаланди';

  @override
  String get tabShop => 'Дўкон';

  @override
  String get tabCategories => 'Туркумлар';

  @override
  String get tabCart => 'Саватча';

  @override
  String get tabFavorites => 'Севимлилар';

  @override
  String get freeShippingBanner =>
      'Бепул етказиб бериш — 200 000 сўмдан юқори буюртмаларга';

  @override
  String get cityTashkent => 'Тошкент';

  @override
  String get help => 'Ёрдам';

  @override
  String get languageUzbek => 'Ўзбекча';

  @override
  String get languageEnglish => 'Инглизча';

  @override
  String get searchProductsHint => 'Маҳсулотлар ёки категорияларни қидиринг...';

  @override
  String get searchShopHint => 'Маҳсулотларни қидиринг...';

  @override
  String get categoryAll => 'Барча';

  @override
  String get heroTitle => 'Янги Маҳсулотлар\nЕнди Уйингизда';

  @override
  String get heroSubtitle => 'Енг яхши ва сара маҳсулотлар фақат бизда';

  @override
  String get heroCta => 'Заказ бериш учун бошла';

  @override
  String get shopCategoriesTitle => 'Категориялар юзасидан харид';

  @override
  String get shopCategoriesSubtitle =>
      'Ошхонангиз учун янги масаллиқлар топинг';

  @override
  String get seeAll => 'Барчасини кўриш';

  @override
  String get seeAllShort => 'Ҳаммаси';

  @override
  String get buy => 'Сотиб олиш';

  @override
  String get addToCart => 'Саватга қўшиш';

  @override
  String get subtotal => 'Оралиқ жами';

  @override
  String get delivery => 'Етказиш';

  @override
  String get free => 'Бепул';

  @override
  String get total => 'Жами';

  @override
  String get checkout => 'Тўлов қилиш';

  @override
  String get cartSummary => 'Харид хулосаси';

  @override
  String get emptyCartTitle => 'Саватчангиз бўш';

  @override
  String get emptyCartSubtitle => 'Бошлаш учун маҳсулот қўшинг';

  @override
  String get noProductsFound => 'Маҳсулот топилмади';

  @override
  String get categoryEmptyProducts => 'Бу категория бўйича маҳсулот ё\'қ.';

  @override
  String get emptyFavoritesTitle => 'Ҳали севимлилар ё\'қ';

  @override
  String get emptyFavoritesSubtitle =>
      'Ёқтирган маҳсулотларингиздаги юракчани босинг';

  @override
  String get removeFavoriteTitle => 'Севимлидан олиб ташлаш';

  @override
  String get removeFavoriteMessage =>
      'Бу маҳсулотни севимлилардан олиб ташлайсизми?';

  @override
  String get logout => 'Чиқиш';

  @override
  String get navOrders => 'Буюртмаларим';

  @override
  String get navProfile => 'Ма\'лумотларим';

  @override
  String get navAddress => 'Етказиш манзили';

  @override
  String get navPayment => 'Тўлов усуллари';

  @override
  String get navPromo => 'Промо кодлар';

  @override
  String get navSettings => 'Созламалар';

  @override
  String get navHelp => 'Ёрдам';

  @override
  String get productFresh => 'Янги ва қишлоқ хўжалиги маҳсулоти';

  @override
  String get organicTitle => '100% Органик';

  @override
  String get organicSubtitle => 'Даладан тўғридан-тўғри уйингизга';

  @override
  String get descriptionTitle => 'Тавсиф';

  @override
  String get categorySubDefault => 'Енг сифатли маҳсулотлар';

  @override
  String get categorySubFruit => 'Табиий ва витаминларга бой';

  @override
  String get categorySubBread => 'Ҳар куни янги';

  @override
  String get categorySubDrink => 'Серсув ва тетиклантирувчи';

  @override
  String get categorySubDairy => 'Тоза ва сифатли';

  @override
  String get categorySubMeat => 'Янги сўйилган ҳалол гўшт';

  @override
  String get userName => 'John Doe';

  @override
  String get userEmail => 'john@example.com';

  @override
  String get phoneNumber => '+998 71 123-45-67';

  @override
  String get productRecommendations => 'Сизга ҳам ёқиши мумкин';

  @override
  String priceCurrency(String amount) {
    return '$amount сўм';
  }
}
