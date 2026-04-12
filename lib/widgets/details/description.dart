import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app/l10n/app_localizations.dart';
import 'package:grocery_app/model/product.dart';
import 'package:grocery_app/util/shopping_colors.dart';

class Description extends StatelessWidget {
  const Description({Key? key, required this.product}) : super(key: key);

  final Product? product;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.descriptionTitle,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: kTextColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          product!.description,
          style: GoogleFonts.poppins(
            fontSize: 14,
            height: 1.6,
            color: kTextSecondary,
          ),
        ),
      ],
    );
  }
}
