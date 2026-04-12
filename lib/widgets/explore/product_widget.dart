import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app/l10n/app_localizations.dart';
import 'package:grocery_app/model/cart.dart';
import 'package:grocery_app/model/product.dart';
import 'package:grocery_app/screens/product_details_screen.dart';
import 'package:grocery_app/util/shopping_colors.dart';
import 'package:provider/provider.dart';

const Color _kPromoCardBg = Color(0xFFF0F0F4);
const Color _kPriceRed = Color(0xFFE53935);

String _formatSum(double value) {
  final s = value.round().toString();
  final buf = StringBuffer();
  for (var i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) buf.write(' ');
    buf.write(s[i]);
  }
  return buf.toString();
}

class ProductWidget extends StatelessWidget {
  const ProductWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cart = Provider.of<Cart>(context);
    final product = Provider.of<Product>(context);
    final isInCart = cart.items.containsKey(product.id);
    final quantity = isInCart ? cart.items[product.id]!.quantity : 0;
    final isMobile = MediaQuery.of(context).size.width < 650;
    final radius = isMobile ? 20.0 : 22.0;
    final horizontalPad = isMobile ? 12.0 : 14.0;
    final bottomPad = isMobile ? 12.0 : 14.0;
    final titleSize = isMobile ? 13.0 : 14.0;
    final unitSize = isMobile ? 12.0 : 12.5;

    return Container(
      decoration: BoxDecoration(
        color: _kPromoCardBg,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: isMobile ? 14 : 18,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Material(
          color: _kPromoCardBg,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push<void>(
                MaterialPageRoute<void>(
                  builder: (ctx) => ProductDetailsScreen(product: product),
                ),
              );
            },
            splashColor: Colors.black.withValues(alpha: 0.06),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
          Expanded(
            flex: isMobile ? 3 : 4,
            child: Stack(
              clipBehavior: Clip.none,
              fit: StackFit.expand,
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(radius)),
                    child: Image.asset(
                      product.imageUrl,
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Consumer<Product>(
                    builder: (ctx, prod, _) {
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => prod.toggleFavoriteStatus(),
                        child: Container(
                          width: isMobile ? 32 : 34,
                          height: isMobile ? 32 : 34,
                          decoration: BoxDecoration(
                            color: Colors.white,
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
                            size: isMobile ? 17 : 18,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                EdgeInsets.fromLTRB(horizontalPad, 6, horizontalPad, bottomPad),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.displayTitle,
                  style: GoogleFonts.poppins(
                    fontSize: titleSize,
                    fontWeight: FontWeight.w600,
                    color: kTextColor,
                    height: 1.25,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (product.displayUnit.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    product.displayUnit,
                    style: GoogleFonts.poppins(
                      fontSize: unitSize,
                      fontWeight: FontWeight.w400,
                      color: kTextLight,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                SizedBox(height: isMobile ? 10 : 12),
                Text(
                  l10n.priceCurrency(_formatSum(product.price)),
                  style: GoogleFonts.poppins(
                    fontSize: isMobile ? 15 : 16,
                    fontWeight: FontWeight.w800,
                    color: _kPriceRed,
                    height: 1.1,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: isMobile ? 6 : 8),
                isInCart
                    ? _buildCounter(context, cart, product, quantity, isMobile)
                    : _buildBuyButton(context, cart, product, isMobile, l10n),
              ],
            ),
          ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBuyButton(
    BuildContext context,
    Cart cart,
    Product product,
    bool compact,
    AppLocalizations l10n,
  ) {
    return Material(
      color: Colors.white,
      elevation: 2,
      shadowColor: Colors.black26,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        onTap: () {
          cart.addItem(
              product.id, product.price, product.title, product.imageUrl);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.addedToCart)),
          );
        },
        borderRadius: BorderRadius.circular(24),
        child: SizedBox(
          width: double.infinity,
          height: compact ? 40 : 44,
          child: Center(
            child: Text(
              l10n.buy,
              style: GoogleFonts.poppins(
                fontSize: compact ? 13 : 14,
                fontWeight: FontWeight.w700,
                color: kTextColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCounter(BuildContext context, Cart cart, Product product,
      int quantity, bool compact) {
    return Container(
      height: compact ? 40 : 44,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => cart.removeSingleItem(product.id),
                borderRadius:
                    const BorderRadius.horizontal(left: Radius.circular(24)),
                child: Center(
                  child: Icon(
                    quantity == 1
                        ? Icons.delete_outline_rounded
                        : Icons.remove_rounded,
                    color: quantity == 1 ? kErrorRed : kTextColor,
                    size: 22,
                  ),
                ),
              ),
            ),
          ),
          Text(
            '$quantity',
            style: GoogleFonts.poppins(
              fontSize: compact ? 15 : 16,
              fontWeight: FontWeight.w700,
              color: kTextColor,
            ),
          ),
          Expanded(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  cart.addItem(product.id, product.price, product.title,
                      product.imageUrl);
                },
                borderRadius:
                    const BorderRadius.horizontal(right: Radius.circular(24)),
                child: const Center(
                  child: Icon(Icons.add_rounded, color: kTextColor, size: 22),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
