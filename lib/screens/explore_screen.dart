import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app/l10n/app_localizations.dart';
import 'package:grocery_app/model/categories.dart';
import 'package:grocery_app/model/product.dart';
import 'package:grocery_app/util/shopping_colors.dart';
import 'package:grocery_app/util/responsive.dart';
import 'package:grocery_app/widgets/explore/product_widget.dart';
import 'package:grocery_app/widgets/shop/category_widget.dart';
import 'package:provider/provider.dart';

class ExploreScreen extends StatelessWidget {
  /// When set (from shop / web header / category grid), show this category's products.
  final String? filterCategoryId;

  /// Called when user picks a category from the grid (parent should set [filterCategoryId]).
  final ValueChanged<String>? onCategorySelected;

  const ExploreScreen({
    Key? key,
    this.filterCategoryId,
    this.onCategorySelected,
  }) : super(key: key);

  bool get _showCategoryGrid => filterCategoryId == null;

  List<Product> _productsForGrid(BuildContext context) {
    final categories = Provider.of<Categories>(context, listen: false);
    if (filterCategoryId == null) return [];
    return categories.getProductsById(context, filterCategoryId!);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final categories = Provider.of<Categories>(context).items;
    final products = _productsForGrid(context);

    return ColoredBox(
      color: kBackgroundColor,
      child: _showCategoryGrid
          ? GridView.builder(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              itemCount: categories.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: Responsive.isMobile(context) ? 2 : 4,
                childAspectRatio: 0.72,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
              ),
              itemBuilder: (ctx, index) {
                final category = categories[index];
                return CategoryWidget(
                  category: category,
                  onTap: (id) {
                    onCategorySelected?.call(id);
                  },
                );
              },
            )
          : products.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.inventory_2_outlined,
                          size: 56,
                          color: kTextLight.withValues(alpha: 0.7),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          l10n.categoryEmptyProducts,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: kTextSecondary,
                            height: 1.4,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                )
              : GridView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                  itemCount: products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: Responsive.getCrossAxisCount(context),
                    childAspectRatio: 0.72,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                  ),
                  itemBuilder: (_, index) {
                    final product = products[index];
                    return ChangeNotifierProvider.value(
                      value: product,
                      child: const ProductWidget(),
                    );
                  },
                ),
    );
  }
}

