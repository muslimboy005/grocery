import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app/model/cart.dart';
import 'package:grocery_app/model/product.dart';
import 'package:grocery_app/model/products.dart';
import 'package:grocery_app/util/shopping_colors.dart';
import 'package:grocery_app/widgets/details/description.dart';
import 'package:provider/provider.dart';

const kDefaultPadding = 20.0;

class ProductDetailsScreen extends StatefulWidget {
  final Product? product;

  const ProductDetailsScreen({Key? key, this.product}) : super(key: key);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final productId = widget.product!.id;
    final productsData = Provider.of<Products>(context);
    final product = productsData.findById(productId);
    final cart = Provider.of<Cart>(context);
    final isInCart = cart.items.containsKey(productId);
    final cartQuantity = isInCart ? cart.items[productId]!.quantity : 0;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: CustomScrollView(
        slivers: [
          // App Bar with Hero Image
          SliverAppBar(
            expandedHeight: size.height * 0.38,
            pinned: true,
            elevation: 0,
            backgroundColor: kSoftGreen,
            surfaceTintColor: Colors.transparent,
            leading: Padding(
              padding: const EdgeInsets.all(8),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  decoration: BoxDecoration(
                    color: kCardColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: const Icon(Icons.arrow_back_rounded, color: kTextColor, size: 20),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: kCardColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: const Icon(Icons.share_outlined, color: kTextColor, size: 20),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: "${product.id}",
                child: Container(
                  color: kSoftGreen.withValues(alpha: 0.6),
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: Image.asset(
                      product.imageUrl,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Content
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                color: kCardColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
              ),
              transform: Matrix4.translationValues(0, -28, 0),
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and price row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.title,
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: kTextColor,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Yangi va qishloq xo\'jaligi mahsuloti',
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: kTextSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: kSoftGreen,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${product.price.toStringAsFixed(0)} so\'m',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: kPrimaryGreen,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Fav 
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => productsData.toggleFavorite(productId),
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: kHeartRed.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          product.isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                          color: product.isFavorite ? kHeartRed : kTextLight,
                          size: 22,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Description
                  Description(product: product),
                  const SizedBox(height: 24),
                  // Nutrition info placeholder
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: kBackgroundColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: kSoftGreen,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.eco_rounded, color: kPrimaryGreen, size: 20),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '100% Organik',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: kTextColor,
                                ),
                              ),
                              Text(
                                'Daladan to\'g\'ridan-to\'g\'ri uyingizga',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: kTextSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Buy Now / Counter
                  isInCart
                      ? _buildCartCounterController(context, cart, product, cartQuantity)
                      : SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton.icon(
                            onPressed: () => cart.addItem(product.id, product.price, product.title, product.imageUrl),
                            icon: const Icon(Icons.shopping_cart_outlined, size: 20),
                            label: Text(
                              'Savatga qo\'shish',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kPrimaryGreen,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                        ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartCounterController(BuildContext context, Cart cart, var product, int quantity) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        color: kSoftGreen,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => cart.removeSingleItem(product.id),
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: kCardColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: kDividerColor),
              ),
              child: Icon(
                quantity == 1 ? Icons.delete_outline_rounded : Icons.remove_rounded,
                color: quantity == 1 ? kErrorRed : kPrimaryGreen,
                size: 24,
              ),
            ),
          ),
          Text(
            '$quantity',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: kPrimaryGreen,
            ),
          ),
          GestureDetector(
            onTap: () => cart.addItem(product.id, product.price, product.title, product.imageUrl),
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: kPrimaryGreen,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.add_rounded, color: Colors.white, size: 24),
            ),
          ),
        ],
      ),
    );
  }
}
