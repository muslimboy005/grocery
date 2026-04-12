import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app/l10n/app_localizations.dart';
import 'package:grocery_app/model/categories.dart';
import 'package:grocery_app/model/category.dart';
import 'package:grocery_app/util/shopping_colors.dart';
import 'package:grocery_app/util/responsive.dart';
import 'package:grocery_app/widgets/explore/product_widget.dart';
import 'package:grocery_app/model/product.dart';
import 'package:provider/provider.dart';

class ShopScreen extends StatefulWidget {
  final Function? categoryClick;
  final VoidCallback? onOpenExplore;

  const ShopScreen({Key? key, this.categoryClick, this.onOpenExplore})
      : super(key: key);

  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final categories = Provider.of<Categories>(context).items;
    bool isMobile = Responsive.isMobile(context);

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: CustomScrollView(
        slivers: [
          // Header
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(isMobile ? 20 : 64, 24, isMobile ? 20 : 64, 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isMobile)
                    Container(
                      margin: const EdgeInsets.only(bottom: 32, top: 0),
                      height: 260,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [kPrimaryGreen, kPrimaryGreenDark],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: kPrimaryGreen.withValues(alpha: 0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            right: -20,
                            top: 20,
                            child: Icon(
                              Icons.shopping_cart_rounded,
                              size: 260,
                              color: Colors.white.withValues(alpha: 0.15),
                            ),
                          ),
                          // Positioned circle removed as per user request

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 48.0, vertical: 32.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  l10n.heroTitle,
                                  style: GoogleFonts.poppins(
                                    fontSize: 32,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    height: 1.2,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  l10n.heroSubtitle,
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: Colors.white.withValues(alpha: 0.9),
                                  ),
                                ),
                                const SizedBox(height: 24),
                                ElevatedButton(
                                  onPressed: widget.onOpenExplore,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: kPrimaryGreenDark,
                                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        l10n.heroCta,
                                        style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                                      ),
                                      const SizedBox(width: 8),
                                      const Icon(Icons.arrow_forward_rounded, size: 18),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (isMobile)
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: widget.onOpenExplore,
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 24, top: 0),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.search_rounded, color: kTextSecondary, size: 22),
                              const SizedBox(width: 12),
                              Text(
                                l10n.searchShopHint,
                                style: GoogleFonts.poppins(color: kTextSecondary, fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  if (isMobile)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.shopCategoriesTitle,
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: kTextColor,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              l10n.shopCategoriesSubtitle,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: kTextSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
          // Grouped Category Sections for All (Mobile & Web)
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final category = categories[index];
                final categoryProducts = Provider.of<Categories>(context, listen: false)
                    .getProductsById(context, category.id);

                if (categoryProducts.isEmpty) return const SizedBox.shrink();

                return _buildCategorySection(context, category, categoryProducts, isMobile);
              },
              childCount: categories.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySection(BuildContext context, Category category, List<dynamic> products, bool isMobile) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 64, vertical: isMobile ? 20 : 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: isMobile ? 40 : 48,
                      height: isMobile ? 40 : 48,
                      color: kSoftGreen,
                      child: Image.asset(
                        category.imageUrl,
                        fit: BoxFit.fill,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ),
                  SizedBox(width: isMobile ? 12 : 16),
                  Text(
                    category.title.replaceAll('\n', ' '),
                    style: GoogleFonts.poppins(
                      fontSize: isMobile ? 18 : 22,
                      fontWeight: FontWeight.w700,
                      color: kTextColor,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  widget.categoryClick!(category.id);
                },
                child: Row(
                  children: [
                    Text(
                      isMobile ? l10n.seeAllShort : l10n.seeAll,
                      style: GoogleFonts.poppins(
                        color: kPrimaryGreenDark,
                        fontWeight: FontWeight.w600,
                        fontSize: isMobile ? 12 : 14,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(Icons.arrow_forward_rounded, color: kPrimaryGreenDark, size: isMobile ? 16 : 20),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: isMobile 
                ? (products.length > 2 ? 2 : products.length) 
                : (products.length > 5 ? 5 : products.length),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 2 : (Responsive.getCrossAxisCount(context) + 1),
              childAspectRatio: isMobile ? 0.75 : 0.72,
              crossAxisSpacing: isMobile ? 16 : 20,
              mainAxisSpacing: isMobile ? 16 : 20,
            ),
            itemBuilder: (context, index) {
              return ChangeNotifierProvider<Product>.value(
                value: products[index] as Product,
                child: ProductWidget(),
              );
            },
          ),
        ],
      ),
    );
  }
}
