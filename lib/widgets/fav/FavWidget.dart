import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app/l10n/app_localizations.dart';
import 'package:grocery_app/model/product.dart';
import 'package:grocery_app/model/products.dart';
import 'package:grocery_app/screens/product_details_screen.dart';
import 'package:grocery_app/util/shopping_colors.dart';
import 'package:provider/provider.dart';

class FavWidget extends StatelessWidget {
  final Product? product;

  const FavWidget({Key? key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Dismissible(
      key: ValueKey(product!.id),
      background: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: kErrorRed,
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        child: const Icon(Icons.delete_outline_rounded, color: Colors.white, size: 26),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Text(
              l10n.removeFavoriteTitle,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: kTextColor),
            ),
            content: Text(
              l10n.removeFavoriteMessage,
              style: GoogleFonts.poppins(color: kTextSecondary),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(l10n.cancel, style: GoogleFonts.poppins(color: kTextSecondary)),
                onPressed: () => Navigator.of(ctx).pop(false),
              ),
              TextButton(
                child: Text(l10n.remove, style: GoogleFonts.poppins(color: kErrorRed, fontWeight: FontWeight.w600)),
                onPressed: () {
                  Provider.of<Products>(context, listen: false).toggleFavorite(product!.id);
                  Navigator.of(ctx).pop(true);
                },
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        Provider.of<Products>(context, listen: false).toggleFavorite(product!.id);
      },
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => ProductDetailsScreen(product: product),
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 6),
          padding: const EdgeInsets.all(12),
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
          child: Row(
            children: [
              // Product image
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: kSoftGreen.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Image.asset(product!.imageUrl, fit: BoxFit.contain),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              // Product details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product!.title,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: kTextColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      l10n.priceCurrency(product!.price.toStringAsFixed(0)),
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: kPrimaryGreen,
                      ),
                    ),
                  ],
                ),
              ),
              // Heart icon
              GestureDetector(
                onTap: () {
                  Provider.of<Products>(context, listen: false).toggleFavorite(product!.id);
                },
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: kHeartRed.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.favorite_rounded,
                    color: kHeartRed,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
