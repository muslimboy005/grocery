import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app/model/product.dart';
import 'package:grocery_app/model/products.dart';
import 'package:grocery_app/screens/product_details_screen.dart';
import 'package:grocery_app/util/shopping_colors.dart';
import 'package:grocery_app/util/responsive.dart';
import 'package:grocery_app/widgets/explore/product_widget.dart';
import 'package:grocery_app/model/categories.dart';
import 'package:grocery_app/widgets/shop/category_widget.dart';
import 'package:provider/provider.dart';

class ExploreScreen extends StatefulWidget {
  final List<Product>? categoryProducts;

  const ExploreScreen({Key? key, this.categoryProducts}) : super(key: key);

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Product> products;
    if (widget.categoryProducts == null || widget.categoryProducts!.isEmpty) {
      products = Provider.of<Products>(context).items;
    } else {
      products = widget.categoryProducts!;
    }

    final categories = Provider.of<Categories>(context).items;
    bool isSearchActive = _searchController.text.isNotEmpty;
    bool isCategoryFilterActive = widget.categoryProducts != null && widget.categoryProducts!.isNotEmpty;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Container(
              decoration: BoxDecoration(
                color: kCardColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 12,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (val) => setState(() {}),
                decoration: InputDecoration(
                  hintText: 'Mahsulotlar yoki kategoriyalarni qidiring...',
                  hintStyle: GoogleFonts.poppins(
                    color: kTextLight,
                    fontSize: 14,
                  ),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(left: 16, right: 12),
                    child: Icon(Icons.search_rounded, color: kPrimaryGreen, size: 22),
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                ),
              ),
            ),
          ),
          // Content: Categories Grid or Product Grid
          Expanded(
            child: (!isSearchActive && !isCategoryFilterActive)
                ? GridView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    itemCount: categories.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: Responsive.isMobile(context) ? 2 : 4,
                      childAspectRatio: 0.95,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                    ),
                    itemBuilder: (ctx, index) {
                      final category = categories[index];
                      return CategoryWidget(
                        category: category,
                        onTap: (id) {
                          setState(() {
                            // In a real app, this would filter or navigate.
                            // For now, we update the local state if needed.
                          });
                        },
                      );
                    },
                  )
                : GridView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    itemCount: products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: Responsive.getCrossAxisCount(context),
                      childAspectRatio: 0.72,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                    ),
                    itemBuilder: (_, index) {
                      Product product = products[index];
                      return ChangeNotifierProvider.value(
                        value: product,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => ProductDetailsScreen(product: product),
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: ProductWidget(),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
