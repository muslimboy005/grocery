import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app/model/categories.dart';
import 'package:grocery_app/model/product.dart';
import 'package:grocery_app/screens/cart_screen.dart';
import 'package:grocery_app/screens/explore_screen.dart';
import 'package:grocery_app/screens/fav_screen.dart';
import 'package:grocery_app/screens/login_screen.dart';
import 'package:grocery_app/screens/shop_screen.dart';
import 'package:grocery_app/util/shopping_colors.dart';
import 'package:grocery_app/widgets/nav_drawer.dart';
import 'package:grocery_app/util/responsive.dart';
import 'package:provider/provider.dart';

class HomeDashBoardScreen extends StatefulWidget {
  @override
  _HomeDashBoardScreenState createState() => _HomeDashBoardScreenState();
}

class _HomeDashBoardScreenState extends State<HomeDashBoardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;
  List<Product> _categoryProducts = [];

  final List<String> _titles = [
    'Do\'kon',
    'Kategoriyalar',
    'Savatcha',
    'Sevimlilar',
  ];

  Widget _buildScreen() {
    switch (_currentIndex) {
      case 1:
        return ExploreScreen(categoryProducts: _categoryProducts);
      case 2:
        return CartScreen();
      case 3:
        return FavScreen();
      case 0:
      default:
        return ShopScreen(
          categoryClick: (String categoryId) {
            setState(() {
              _categoryProducts = Provider.of<Categories>(context, listen: false)
                  .getProductsById(context, categoryId);
              _currentIndex = 1;
            });
          },
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);

    Widget mainScreenOptions = AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: _buildScreen(),
    );

    if (!isMobile) {
      return Scaffold(
        key: _scaffoldKey,
        backgroundColor: kBackgroundColor,
        body: Column(
          children: [
            // Top Info Bar
            LayoutBuilder(
              builder: (context, constraints) {
                bool showAll = constraints.maxWidth > 1100;
                bool showMost = constraints.maxWidth > 900;
                return Container(
                  height: 36,
                  color: const Color(0xFFE8F5E9),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      const Icon(Icons.local_shipping_outlined, color: kPrimaryGreen, size: 16),
                      const SizedBox(width: 8),
                      if (showMost)
                        Flexible(
                          child: Text(
                            'Bepul yetkazib berish — 200 000 so\'mdan yuqori buyurtmalarga',
                            style: GoogleFonts.poppins(fontSize: 12, color: kPrimaryGreenDark, fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      if (showMost) const SizedBox(width: 16),
                      const Icon(Icons.location_on_outlined, color: kTextSecondary, size: 16),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          'Toshkent',
                          style: GoogleFonts.poppins(fontSize: 12, color: kTextSecondary),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Spacer(),
                      if (showAll) ...[
                        const Icon(Icons.phone_outlined, color: kTextSecondary, size: 16),
                        const SizedBox(width: 4),
                        Text('+998 71 123-45-67', style: GoogleFonts.poppins(fontSize: 12, color: kTextSecondary)),
                        const SizedBox(width: 16),
                      ],
                      const Icon(Icons.help_outline_rounded, color: kTextSecondary, size: 16),
                      const SizedBox(width: 4),
                      Text('Yordam', style: GoogleFonts.poppins(fontSize: 12, color: kTextSecondary)),
                      const SizedBox(width: 16),
                      Text('O\'zbekcha', style: GoogleFonts.poppins(fontSize: 12, color: kTextColor, fontWeight: FontWeight.w500)),
                      const Icon(Icons.keyboard_arrow_down_rounded, color: kTextColor, size: 16),
                    ],
                  ),
                );
              },
            ),
            // Main Header
            LayoutBuilder(
              builder: (context, constraints) {
                bool hideSearchLabel = constraints.maxWidth < 950;
                bool hideName = constraints.maxWidth < 1150;
                
                return Container(
                  height: 80,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  decoration: const BoxDecoration(
                    color: kCardColor,
                  ),
                  child: Row(
                    children: [
                      // Logo
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: kPrimaryGreen,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.shopping_basket_rounded, color: Colors.white, size: 24),
                          ),
                          const SizedBox(width: 12),
                          if (constraints.maxWidth > 850)
                            Text(
                              'MyShop',
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                color: kTextColor,
                                letterSpacing: -0.5,
                              ),
                            ),
                        ],
                      ),
                      const Spacer(),
                      // Advanced Search Bar
                      Flexible(
                        flex: 3,
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 500),
                          height: 48,
                          decoration: BoxDecoration(
                            color: kBackgroundColor,
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: kDividerColor),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 16),
                              if (!hideSearchLabel) ...[
                                Text('Barcha', style: GoogleFonts.poppins(fontSize: 13, color: kTextColor, fontWeight: FontWeight.w500)),
                                const Icon(Icons.keyboard_arrow_down_rounded, color: kTextColor, size: 18),
                                Container(
                                  width: 1,
                                  height: 24,
                                  color: kDividerColor,
                                  margin: const EdgeInsets.symmetric(horizontal: 12),
                                ),
                              ],
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Qidirish...',
                                    hintStyle: GoogleFonts.poppins(fontSize: 13, color: kTextSecondary),
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.only(bottom: 4),
                                  ),
                                ),
                              ),
                              Container(
                                width: 40,
                                height: 40,
                                margin: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(color: kPrimaryGreen, shape: BoxShape.circle),
                                child: const Icon(Icons.search_rounded, color: Colors.white, size: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      // Cart, Fav & Profile
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () => setState(() => _currentIndex = 2),
                            child: const Icon(Icons.shopping_bag_outlined, color: kTextColor, size: 24),
                          ),
                          const SizedBox(width: 16),
                          GestureDetector(
                            onTap: () => setState(() => _currentIndex = 3),
                            child: const Icon(Icons.favorite_border_rounded, color: kTextColor, size: 24),
                          ),
                          const SizedBox(width: 16),
                          Container(width: 1, height: 32, color: kDividerColor),
                          const SizedBox(width: 16),
                          ClipOval(
                            child: Image.asset(
                              'shopping_assets/images/user.png',
                              width: 36,
                              height: 36,
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                            ),
                          ),
                          if (!hideName) ...[
                            const SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                'John Doe',
                                style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: kTextColor),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
            // Sub-header Navigation
            Container(
              height: 64,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              decoration: const BoxDecoration(
                color: kCardColor,
                border: Border(bottom: BorderSide(color: kDividerColor)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: kPrimaryGreenDark,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.menu_rounded, color: Colors.white, size: 18),
                        const SizedBox(width: 8),
                        Text('Barchasi', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24),
                  // Dynamic Categories in Header
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: Provider.of<Categories>(context).items.take(7).map((category) => Padding(
                              padding: const EdgeInsets.only(right: 24),
                              child: _buildWebCategoryNavItem(category),
                            )).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Takliflar and Premium removed as per user request
                ],
              ),
            ),
            // Main Content Area
            Expanded(
              child: Container(
                color: kBackgroundColor,
                child: mainScreenOptions,
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      key: _scaffoldKey,
      drawer: NavDrawer(),
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: kCardColor,
        surfaceTintColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () => _scaffoldKey.currentState!.openDrawer(),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: kDividerColor,
                  width: 1.5,
                ),
              ),
              child: ClipOval(
                child: Image.asset(
                  'shopping_assets/images/user.png',
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
          ),
        ),
        centerTitle: true,
        title: Column(
          children: [
            Text(
              _titles[_currentIndex],
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: kTextColor,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => LoginUI()),
                );
              },
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: kBackgroundColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.logout_rounded,
                  size: 20,
                  color: kTextSecondary,
                ),
              ),
            ),
          ),
        ],
      ),
      body: mainScreenOptions,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: kCardColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0, Icons.storefront_rounded, 'Do\'kon'),
                _buildNavItem(1, Icons.grid_view_rounded, 'Turkumlar'),
                _buildNavItem(2, Icons.shopping_cart_rounded, 'Savatcha'),
                _buildNavItem(3, Icons.favorite_rounded, 'Sevimlilar'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 16 : 12,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: isSelected ? kSoftGreen : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? kPrimaryGreen : kTextLight,
              size: 22,
            ),
            if (isSelected) ...[
              const SizedBox(width: 6),
              Text(
                label,
                style: GoogleFonts.poppins(
                  color: kPrimaryGreen,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildWebCategoryNavItem(dynamic category) {
    return InkWell(
      onTap: () {
        setState(() {
          _currentIndex = 0; // Go to Shop
          _categoryProducts = Provider.of<Categories>(context, listen: false)
              .getProductsById(context, category.id);
          _currentIndex = 1; // Then to Explore with results
        });
      },
      onHover: (hovering) {},
      child: Text(
        category.title.replaceAll('\n', ' '),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.poppins(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: kTextColor,
        ),
      ),
    );
  }
}
