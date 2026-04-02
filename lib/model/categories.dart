import 'package:flutter/material.dart';
import 'category.dart';
import 'products.dart';
import 'package:provider/provider.dart';

import './product.dart';

class Categories with ChangeNotifier {
  List<Category> _items = [
    Category(
        id: 'c1',
        title: 'Yangi mevalar',
        imageUrl: 'shopping_assets/images/fruits/cover.png',
        products: ['p1', 'p2', 'p3', 'p4', 'p5', 'p6']),
    Category(
      id: 'c4',
      title: 'Non va\npishiriqlar',
      imageUrl: 'shopping_assets/images/bakery_snacks/cover.png',
    ),
    Category(
      id: 'c6',
      title: 'Ichimliklar',
      imageUrl: 'shopping_assets/images/beverage/cover.png',
    ),
    Category(
      id: 'c5',
      title: 'Sut va\ntuxum',
      imageUrl: 'shopping_assets/images/dairy_eggs/cover.png',
    ),
    Category(
        id: 'c2',
        title: 'Sabzavotlar',
        imageUrl: 'shopping_assets/images/vegetables/vegetables_cover.png',
        products: ['p7', 'p8', 'p9', 'p10', 'p11', 'p12']),
    Category(
      id: 'c3',
      title: "O'simlik moyi",
      imageUrl: 'shopping_assets/images/cooking_oil/cooking_cover.png',
    ),
    Category(
        id: 'c7',
        title: 'Mevalar',
        imageUrl: 'shopping_assets/images/fruits/cover.png',
        products: ['p1', 'p2', 'p5', 'p6']),
    Category(
      id: 'c8',
      title: 'Gazaklar',
      imageUrl: 'shopping_assets/images/bakery_snacks/cover.png',
    ),
    Category(
      id: 'c9',
      title: 'Tuxum',
      imageUrl: 'shopping_assets/images/dairy_eggs/cover.png',
    ),
  ];

  List<Category> get items {
    return [..._items];
  }

  List<Product> getProductsById(BuildContext context, String id) {
    List<Product> list = [];
    final category = _items.firstWhere((cat) => cat.id == id);
    if (category.products == null) return list;
    for (String productId in category.products!) {
      list.add(Provider.of<Products>(context, listen: false).findById(productId));
    }
    return list;
  }

  Category findCategoryByTitle(String categoryTitle) {
    return _items.firstWhere((prod) => prod.title.contains(categoryTitle));
  }

  Category findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }
}
