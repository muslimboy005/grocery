import 'package:flutter/material.dart';

import './product.dart';

class Products with ChangeNotifier {
  static String dummyDesc =
      "Yangi va sifatli mahsulot. Har kuni dehqon xo'jaligidan yetkazib beriladi. Tabiiy va ekologik toza.";

  List<Product> _items = [
    /// Mevalar
    Product(
      id: 'p1',
      title: 'Olma/kg',
      price: 15000,
      imageUrl: 'shopping_assets/images/fruits/apple.png',
      description: dummyDesc,
    ),
    Product(
      id: 'p5',
      title: 'Apelsin/kg',
      price: 25000,
      imageUrl: 'shopping_assets/images/fruits/orange.png',
      description: dummyDesc,
    ),
    Product(
      id: 'p6',
      title: 'Ananas/dona',
      price: 45000,
      imageUrl: 'shopping_assets/images/fruits/pineapple.png',
      description: dummyDesc,
    ),
    Product(
      id: 'p2',
      title: 'Banan/kg',
      price: 22000,
      imageUrl: 'shopping_assets/images/fruits/banana.png',
      description: dummyDesc,
    ),
    Product(
      id: 'p3',
      title: 'Limon/kg',
      price: 18000,
      imageUrl: 'shopping_assets/images/fruits/lemon.png',
      description: dummyDesc,
    ),
    Product(
      id: 'p4',
      title: 'Mango/dona',
      price: 35000,
      imageUrl: 'shopping_assets/images/fruits/mango.png',
      description: dummyDesc,
    ),

    /// Sabzavotlar
    Product(
      id: 'p7',
      title: 'Sabzi/kg',
      price: 8000,
      imageUrl: 'shopping_assets/images/vegetables/carrot.png',
      description: dummyDesc,
    ),
    Product(
      id: 'p8',
      title: 'Bodring/kg',
      price: 12000,
      imageUrl: 'shopping_assets/images/vegetables/cucumber.png',
      description: dummyDesc,
    ),
    Product(
      id: 'p9',
      title: 'Piyoz/kg',
      price: 7000,
      imageUrl: 'shopping_assets/images/vegetables/onion.png',
      description: dummyDesc,
    ),
    Product(
      id: 'p10',
      title: 'Kartoshka/kg',
      price: 6000,
      imageUrl: 'shopping_assets/images/vegetables/potato.png',
      description: dummyDesc,
    ),
    Product(
      id: 'p11',
      title: 'Qalampir/kg',
      price: 15000,
      imageUrl: 'shopping_assets/images/vegetables/red_chillies.png',
      description: dummyDesc,
    ),
    Product(
      id: 'p12',
      title: 'Pomidor/kg',
      price: 10000,
      imageUrl: 'shopping_assets/images/vegetables/tomato.png',
      description: dummyDesc,
    ),
  ];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  void addProduct(Product product) {
    final newProduct = Product(
      title: product.title,
      price: product.price,
      imageUrl: product.imageUrl,
      id: DateTime.now().toString(),
      description: dummyDesc,
    );
    _items.add(newProduct);
    notifyListeners();
  }

  void updateProduct(String id, Product newProduct) {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = newProduct;
      notifyListeners();
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }

  void toggleFavorite(String id) {
    final prod = findById(id);
    prod.toggleFavoriteStatus();
    notifyListeners();
  }
}
