import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app/l10n/app_localizations.dart';
import 'package:grocery_app/model/cart.dart';
import 'package:grocery_app/model/orders.dart';
import 'package:grocery_app/util/shopping_colors.dart';
import 'package:grocery_app/util/responsive.dart';
import 'package:grocery_app/widgets/cart/cart_widget.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cart = Provider.of<Cart>(context);
    bool isMobile = Responsive.isMobile(context);

    Widget emptyCartWidget = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: kSoftGreen,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.shopping_cart_outlined,
              size: 36,
              color: kPrimaryGreen,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.emptyCartTitle,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: kTextColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.emptyCartSubtitle,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: kTextSecondary,
            ),
          ),
        ],
      ),
    );

    Widget cartItemsWidget = cart.items.isEmpty
        ? emptyCartWidget
        : ListView.builder(
            padding: EdgeInsets.fromLTRB(16, 8, 16, isMobile ? 8 : 24),
            itemCount: cart.items.length,
            itemBuilder: (ctx, i) => CartWidget(
              cart.items.values.toList()[i].id,
              cart.items.keys.toList()[i],
              cart.items.values.toList()[i].price,
              cart.items.values.toList()[i].quantity,
              cart.items.values.toList()[i].title,
              cart.items.values.toList()[i].imageUrl,
            ),
          );

    Widget summaryWidget = Container(
      padding: EdgeInsets.fromLTRB(20, 16, 20, isMobile ? 20 : 32),
      decoration: BoxDecoration(
        color: kCardColor,
        borderRadius: isMobile
            ? const BorderRadius.vertical(top: Radius.circular(24))
            : BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!isMobile)
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Text(
                  l10n.cartSummary,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: kTextColor,
                  ),
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.subtotal,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: kTextSecondary,
                  ),
                ),
                Text(
                  l10n.priceCurrency(cart.totalAmount.toStringAsFixed(0)),
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: kTextColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.delivery,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: kTextSecondary,
                  ),
                ),
                Text(
                  l10n.free,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: kPrimaryGreen,
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Divider(color: kDividerColor),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.total,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: kTextColor,
                  ),
                ),
                Text(
                  l10n.priceCurrency(cart.totalAmount.toStringAsFixed(0)),
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: kPrimaryGreen,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: () {
                  Provider.of<Orders>(context, listen: false).addOrder(
                    cart.items.values.toList(),
                    cart.totalAmount,
                  );
                  cart.clear();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(l10n.orderPlaced)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryGreen,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  l10n.checkout,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    if (!isMobile) {
      return Scaffold(
        backgroundColor: kBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: cartItemsWidget,
              ),
              if (cart.items.isNotEmpty) ...[
                const SizedBox(width: 32),
                Expanded(
                  flex: 1,
                  child: summaryWidget,
                ),
              ]
            ],
          ),
        ),
      );
    }

    return Column(
      children: <Widget>[
        Expanded(child: cartItemsWidget),
        if (cart.items.isNotEmpty) summaryWidget,
      ],
    );
  }
}
