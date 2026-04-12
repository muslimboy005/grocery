import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app/l10n/app_localizations.dart';
import 'package:grocery_app/model/cart.dart';
import 'package:grocery_app/model/product.dart';
import 'package:grocery_app/util/shopping_colors.dart';
import 'package:provider/provider.dart';

class BuyNow extends StatelessWidget {
  const BuyNow({Key? key, required this.product}) : super(key: key);

  final Product? product;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton.icon(
        onPressed: product == null
            ? null
            : () {
                final cart = Provider.of<Cart>(context, listen: false);
                cart.addItem(product!.id, product!.price, product!.title, product!.imageUrl);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.addedToCart)),
                );
              },
        icon: const Icon(Icons.shopping_bag_rounded, size: 20),
        label: Text(
          l10n.addToCart,
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
    );
  }
}
