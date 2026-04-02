import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app/model/categories.dart';
import 'package:grocery_app/model/category.dart';
import 'package:grocery_app/util/shopping_colors.dart';
import 'package:grocery_app/util/responsive.dart';
import 'package:grocery_app/widgets/nav_drawer.dart';
import 'package:grocery_app/widgets/shop/category_widget.dart';
import 'package:provider/provider.dart';

class ShopScreen extends StatefulWidget {
  final Function? categoryClick;

  const ShopScreen({Key? key, this.categoryClick}) : super(key: key);

  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<Categories>(context).items;
    return Row(
      children: [
        if (!Responsive.isMobile(context)) NavDrawer(),
        Expanded(
          child: CustomScrollView(
            slivers: [
              // Header
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Kategoriyalar yuzasidan xarid',
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: kTextColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Oshxonangiz uchun yangi masalliqlar toping',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: kTextSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Grid
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: Responsive.getCrossAxisCount(context),
                    childAspectRatio: 1.1,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (_, index) {
                      Category category = categories[index];
                      return CategoryWidget(
                        category: category,
                        onTap: (String id) {
                          widget.categoryClick!(id);
                        },
                      );
                    },
                    childCount: categories.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
