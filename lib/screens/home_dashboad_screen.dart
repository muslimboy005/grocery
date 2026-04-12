import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app/l10n/app_localizations.dart';
import 'package:grocery_app/l10n/locale_controller.dart';
import 'package:grocery_app/model/categories.dart';
import 'package:grocery_app/model/category.dart';
import 'package:grocery_app/screens/cart_screen.dart';
import 'package:grocery_app/screens/explore_screen.dart';
import 'package:grocery_app/screens/fav_screen.dart';
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

  /// Explore: when non-null, that category's product list is shown (may be empty).
  String? _exploreFilterCategoryId;

  /// Web header: `null` means "Barcha" (all) is selected.
  String? _selectedWebCategoryId;

  /// True when product list opened from Shop "Hammasi" — back returns to Shop, not Turkumlar grid.
  bool _exploreProductListFromShop = false;

  List<String> _titles(AppLocalizations l10n) => [
        l10n.tabShop,
        l10n.tabCategories,
        l10n.tabCart,
        l10n.tabFavorites,
      ];

  void _openExploreCategories() {
    setState(() {
      _exploreFilterCategoryId = null;
      _selectedWebCategoryId = null;
      _exploreProductListFromShop = false;
      _currentIndex = 1;
    });
  }

  Widget _buildScreen() {
    switch (_currentIndex) {
      case 1:
        return ExploreScreen(
          key: ValueKey<String>(
              'explore_${_exploreFilterCategoryId ?? 'grid'}'),
          filterCategoryId: _exploreFilterCategoryId,
          onCategorySelected: (id) {
            setState(() {
              _exploreFilterCategoryId = id;
              _selectedWebCategoryId = id;
              _exploreProductListFromShop = false;
            });
          },
        );
      case 2:
        return CartScreen();
      case 3:
        return FavScreen();
      case 0:
      default:
        return ShopScreen(
          key: const ValueKey<String>('shop'),
          categoryClick: (String categoryId) {
            setState(() {
              _exploreFilterCategoryId = categoryId;
              _selectedWebCategoryId = categoryId;
              _exploreProductListFromShop = true;
              _currentIndex = 1;
            });
          },
          onOpenExplore: _openExploreCategories,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final localeCtl = context.watch<LocaleController>();
    final titles = _titles(l10n);
    bool isMobile = Responsive.isMobile(context);

    Widget mainScreenOptions = AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: KeyedSubtree(
        key: ValueKey<String>(
            'main_${_currentIndex}_${_exploreFilterCategoryId ?? 'nil'}'),
        child: _buildScreen(),
      ),
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
                      const Icon(Icons.local_shipping_outlined,
                          color: kPrimaryGreen, size: 16),
                      const SizedBox(width: 8),
                      if (showMost)
                        Flexible(
                          child: Text(
                            l10n.freeShippingBanner,
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: kPrimaryGreenDark,
                                fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      if (showMost) const SizedBox(width: 16),
                      const Icon(Icons.location_on_outlined,
                          color: kTextSecondary, size: 16),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          l10n.cityTashkent,
                          style: GoogleFonts.poppins(
                              fontSize: 12, color: kTextSecondary),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Spacer(),
                      if (showAll) ...[
                        const Icon(Icons.phone_outlined,
                            color: kTextSecondary, size: 16),
                        const SizedBox(width: 4),
                        Text(l10n.phoneNumber,
                            style: GoogleFonts.poppins(
                                fontSize: 12, color: kTextSecondary)),
                        const SizedBox(width: 16),
                      ],
                      const Icon(Icons.help_outline_rounded,
                          color: kTextSecondary, size: 16),
                      const SizedBox(width: 4),
                      Text(l10n.help,
                          style: GoogleFonts.poppins(
                              fontSize: 12, color: kTextSecondary)),
                      const SizedBox(width: 16),
                      PopupMenuButton<Locale>(
                        padding: EdgeInsets.zero,
                        offset: const Offset(0, 28),
                        onSelected: (loc) =>
                            context.read<LocaleController>().setLocale(loc),
                        itemBuilder: (context) {
                          return LocaleController.pickerLocales.map((loc) {
                            final selected = LocaleController.sameLocale(
                                loc, localeCtl.locale);
                            return PopupMenuItem<Locale>(
                              value: loc,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 22,
                                    child: selected
                                        ? Icon(
                                            Icons.check_rounded,
                                            size: 18,
                                            color: kPrimaryGreenDark,
                                          )
                                        : null,
                                  ),
                                  Expanded(
                                    child: Text(
                                      LocaleController.menuItemLabel(loc),
                                      style: GoogleFonts.inter(
                                        fontSize: 13,
                                        color: kTextColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList();
                        },
                        child: SizedBox(
                          width: 148,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Flexible(
                                child: Text(
                                  LocaleController.chipLabel(localeCtl.locale),
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: kTextColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: kTextColor,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            // Main Header
            LayoutBuilder(
              builder: (context, constraints) {
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
                            child: const Icon(Icons.shopping_basket_rounded,
                                color: Colors.white, size: 24),
                          ),
                          const SizedBox(width: 12),
                          if (constraints.maxWidth > 850)
                            Text(
                              l10n.appTitle,
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
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: kDividerColor),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 1),
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: l10n.searchShopHint,
                                    hintStyle: GoogleFonts.poppins(
                                      fontSize: 13,
                                      color: kTextSecondary,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.only(
                                        bottom: 4, left: 8),
                                  ),
                                ),
                              ),
                              Container(
                                width: 40,
                                height: 40,
                                margin: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                    color: kPrimaryGreen,
                                    shape: BoxShape.circle),
                                child: const Icon(Icons.search_rounded,
                                    color: Colors.white, size: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      // Cart, Fav & Profile
                      Flexible(
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () => setState(() => _currentIndex = 2),
                              child: const Icon(Icons.shopping_bag_outlined,
                                  color: kTextColor, size: 24),
                            ),
                            const SizedBox(width: 16),
                            GestureDetector(
                              onTap: () => setState(() => _currentIndex = 3),
                              child: const Icon(Icons.favorite_border_rounded,
                                  color: kTextColor, size: 24),
                            ),
                            const SizedBox(width: 16),
                            Container(
                                width: 1, height: 32, color: kDividerColor),
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
                                  l10n.userName,
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: kTextColor),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ],
                        ),
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
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _selectedWebCategoryId = null;
                          _exploreFilterCategoryId = null;
                          _currentIndex = 0;
                        });
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: _selectedWebCategoryId == null
                              ? kPrimaryGreenDark
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                          border: _selectedWebCategoryId == null
                              ? null
                              : Border.all(color: kDividerColor),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.menu_rounded,
                              color: _selectedWebCategoryId == null
                                  ? Colors.white
                                  : kTextColor,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              l10n.categoryAll,
                              style: GoogleFonts.poppins(
                                color: _selectedWebCategoryId == null
                                    ? Colors.white
                                    : kTextColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 24),
                  // Dynamic Categories in Header
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: Provider.of<Categories>(context)
                            .items
                            .map((category) {
                          final selected =
                              category.id == _selectedWebCategoryId;
                          return Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: _buildWebCategoryNavItem(category, selected),
                          );
                        }).toList(),
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
      drawer: const NavDrawer(),
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: kCardColor,
        surfaceTintColor: Colors.transparent,
        leading: _currentIndex == 1 && _exploreFilterCategoryId != null
            ? IconButton(
                onPressed: () {
                  setState(() {
                    if (_exploreProductListFromShop) {
                      _exploreFilterCategoryId = null;
                      _selectedWebCategoryId = null;
                      _exploreProductListFromShop = false;
                      _currentIndex = 0;
                    } else {
                      _exploreFilterCategoryId = null;
                      _selectedWebCategoryId = null;
                    }
                  });
                },
                padding: const EdgeInsets.all(10),
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: kBackgroundColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: kDividerColor, width: 1),
                  ),
                  child: const Icon(
                    Icons.arrow_back_rounded,
                    size: 20,
                    color: kTextColor,
                  ),
                ),
              )
            : GestureDetector(
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
              titles[_currentIndex],
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: kTextColor,
              ),
            ),
          ],
        ),
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
                _buildNavItem(0, Icons.storefront_rounded, l10n.tabShop),
                _buildNavItem(1, Icons.grid_view_rounded, l10n.tabCategories),
                _buildNavItem(2, Icons.shopping_cart_rounded, l10n.tabCart),
                _buildNavItem(3, Icons.favorite_rounded, l10n.tabFavorites),
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
      onTap: () {
        setState(() {
          if (index == 0) {
            _exploreProductListFromShop = false;
          }
          _currentIndex = index;
        });
      },
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

  Widget _buildWebCategoryNavItem(Category category, bool selected) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedWebCategoryId = category.id;
            _exploreFilterCategoryId = category.id;
            _exploreProductListFromShop = false;
            _currentIndex = 1;
          });
        },
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: selected ? kPrimaryGreenDark : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            category.title.replaceAll('\n', ' '),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: selected ? Colors.white : kTextColor,
            ),
          ),
        ),
      ),
    );
  }
}
