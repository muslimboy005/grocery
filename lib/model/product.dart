import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final double price;
  final String imageUrl;
  final String description;
  bool isFavorite;

  /// Weight / pack size line under the title; if null, parsed from `title` after "/".
  final String? unitLabel;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.description,
    this.isFavorite = false,
    this.unitLabel,
  });

  String get displayTitle {
    final i = title.indexOf('/');
    if (i < 0) return title;
    return title.substring(0, i).trim();
  }

  String get displayUnit {
    if (unitLabel != null && unitLabel!.isNotEmpty) return unitLabel!;
    final i = title.indexOf('/');
    if (i < 0) return '';
    return title.substring(i + 1).trim();
  }

  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
