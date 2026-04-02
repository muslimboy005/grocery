import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app/model/cart.dart';
import 'package:grocery_app/model/product.dart';
import 'package:grocery_app/util/shopping_colors.dart';
import 'package:provider/provider.dart';

class ProductWidget extends StatelessWidget {
  @override
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final product = Provider.of<Product>(context);
    final isInCart = cart.items.containsKey(product.id);
    final quantity = isInCart ? cart.items[product.id]!.quantity : 0;
    
    // Import from responsive.dart using absolute path structure in context, or directly rely on UI constraint
    bool isMobile = MediaQuery.of(context).size.width < 650;

    if (!isMobile) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image section - Ensures all images are cropped to exactly the same bounds
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    child: Image.asset(
                      product.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Like button (top-right)
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Consumer<Product>(
                      builder: (ctx, prod, _) {
                        return GestureDetector(
                          onTap: () => prod.toggleFavoriteStatus(),
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Icon(
                              prod.isFavorite
                                  ? Icons.favorite_rounded
                                  : Icons.favorite_border_rounded,
                              color: prod.isFavorite ? kPrimaryGreen : const Color(0xFFBDBDBD),
                              size: 18,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            // Text + button section
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    product.title,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: kTextColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      '${product.price.toStringAsFixed(0)} so\'m',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: kPrimaryGreenDark,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Savatga button OR counter
                  isInCart
                      ? _buildCounter(context, cart, product, quantity)
                      : _buildAddButton(context, cart, product),
                ],
              ),
            ),
          ],
        ),
      );
    }

    // ORIGINAL MOBILE LAYOUT
    return Container(
      decoration: BoxDecoration(
        color: kCardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image section
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: kSoftGreen.withValues(alpha: 0.5),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Image.asset(
                        product.imageUrl,
                        fit: BoxFit.contain, // Orig Mobile style
                      ),
                    ),
                  ),
                ),
                // Like button (top-right)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Consumer<Product>(
                    builder: (ctx, prod, _) {
                      return GestureDetector(
                        onTap: () => prod.toggleFavoriteStatus(),
                        child: Container(
                          width: 34,
                          height: 34,
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
                          child: Icon(
                            prod.isFavorite
                                ? Icons.favorite_rounded
                                : Icons.favorite_border_rounded,
                            color: prod.isFavorite ? kHeartRed : kTextLight,
                            size: 18,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          // Text + button section
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: kTextColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  '${product.price.toStringAsFixed(0)} so\'m',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: kPrimaryGreen,
                  ),
                ),
                const SizedBox(height: 8),
                // Savatga button OR counter
                isInCart
                    ? _buildCounter(context, cart, product, quantity)
                    : _buildAddButton(context, cart, product),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddButton(BuildContext context, Cart cart, Product product) {
    return SizedBox(
      width: double.infinity,
      height: 36,
      child: ElevatedButton.icon(
        onPressed: () {
          cart.addItem(product.id, product.price, product.title, product.imageUrl);
        },
        icon: const Icon(Icons.shopping_cart_outlined, size: 16),
        label: Text(
          'Savatga',
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryGreen,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildCounter(BuildContext context, Cart cart, Product product, int quantity) {
    return Container(
      height: 36,
      decoration: BoxDecoration(
        color: kSoftGreen,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => cart.removeSingleItem(product.id),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: kCardColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: kDividerColor),
              ),
              child: Icon(
                quantity == 1 ? Icons.delete_outline_rounded : Icons.remove_rounded,
                color: quantity == 1 ? kErrorRed : kPrimaryGreen,
                size: 18,
              ),
            ),
          ),
          Text(
            '$quantity',
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: kPrimaryGreen,
            ),
          ),
          GestureDetector(
            onTap: () {
              cart.addItem(product.id, product.price, product.title, product.imageUrl);
            },
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: kPrimaryGreen,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.add_rounded, color: Colors.white, size: 18),
            ),
          ),
        ],
      ),
    );
  }
}