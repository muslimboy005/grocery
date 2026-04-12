import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app/l10n/app_localizations.dart';
import 'package:grocery_app/model/cart.dart';
import 'package:grocery_app/model/product.dart';
import 'package:grocery_app/model/products.dart';
import 'package:grocery_app/util/responsive.dart';
import 'package:grocery_app/util/shopping_colors.dart';
import 'package:grocery_app/widgets/details/description.dart';
import 'package:provider/provider.dart';

String _formatSumSpaced(double value) {
  final s = value.round().toString();
  final buf = StringBuffer();
  for (var i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) buf.write(' ');
    buf.write(s[i]);
  }
  return buf.toString();
}

class ProductDetailsScreen extends StatefulWidget {
  final Product? product;

  const ProductDetailsScreen({Key? key, this.product}) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  void _shareProduct(Product product) {
    final l10n = AppLocalizations.of(context)!;
    Clipboard.setData(ClipboardData(text: product.title));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.linkCopied)),
    );
  }

  void _openProduct(BuildContext context, Product p) {
    Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (ctx) => ProductDetailsScreen(product: p),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;
    final productId = widget.product!.id;
    final productsData = Provider.of<Products>(context);
    final product = productsData.findById(productId);
    final cart = Provider.of<Cart>(context);
    final isInCart = cart.items.containsKey(productId);
    final cartQuantity = isInCart ? cart.items[productId]!.quantity : 0;
    final isMobile = Responsive.isMobile(context);
    final recommendations = productsData.items
        .where((p) => p.id != product.id)
        .take(10)
        .toList();

    final priceStr = _formatSumSpaced(product.price);
    final priceLine = l10n.priceCurrency(priceStr);

    final bodyContent = _DetailBody(
      l10n: l10n,
      product: product,
      priceLine: priceLine,
      recommendations: recommendations,
      onOpenRelated: (p) => _openProduct(context, p),
      showInlineCartCta: !isMobile,
      mobilePriceAboveBottomBar: isMobile,
      isInCart: isInCart,
      cartQuantity: cartQuantity,
      cart: cart,
    );

    if (!isMobile) {
      return Scaffold(
        backgroundColor: kBackgroundColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          _RoundIconButton(
                            icon: Icons.arrow_back_rounded,
                            onTap: () => Navigator.pop(context),
                          ),
                          const Spacer(),
                          _RoundIconButton(
                            icon: Icons.share_outlined,
                            onTap: () => _shareProduct(product),
                          ),
                          const SizedBox(width: 8),
                          _RoundIconButton(
                            icon: product.isFavorite
                                ? Icons.favorite_rounded
                                : Icons.favorite_border_rounded,
                            iconColor:
                                product.isFavorite ? kHeartRed : kTextColor,
                            onTap: () => productsData.toggleFavorite(productId),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Expanded(
                        child: Hero(
                          tag: product.id,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(32),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.06),
                                  blurRadius: 32,
                                  offset: const Offset(0, 12),
                                ),
                              ],
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: Image.asset(
                              product.imageUrl,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                              alignment: Alignment.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 48),
                Expanded(
                  flex: 4,
                  child: SingleChildScrollView(
                    child: bodyContent,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: kCardColor,
      extendBody: true,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: size.height * 0.42,
            pinned: true,
            stretch: true,
            elevation: 0,
            backgroundColor: kCardColor,
            surfaceTintColor: Colors.transparent,
            leading: Padding(
              padding: const EdgeInsets.all(8),
              child: _RoundIconButton(
                icon: Icons.arrow_back_rounded,
                onTap: () => Navigator.pop(context),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: _RoundIconButton(
                  icon: Icons.share_outlined,
                  onTap: () => _shareProduct(product),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: _RoundIconButton(
                  icon: product.isFavorite
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                  iconColor: product.isFavorite ? kHeartRed : kTextColor,
                  onTap: () => productsData.toggleFavorite(productId),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
              ],
              background: Stack(
                fit: StackFit.expand,
                clipBehavior: Clip.hardEdge,
                children: [
                  Positioned.fill(
                    child: Hero(
                      tag: product.id,
                      child: Image.asset(
                        product.imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Transform.translate(
              offset: const Offset(0, -10),
              child: Material(
                color: kCardColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(28),
                ),
                clipBehavior: Clip.antiAlias,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 108),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 28),
                      bodyContent,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _MobileCartBar(
        l10n: l10n,
        product: product,
        cart: cart,
        isInCart: isInCart,
        cartQuantity: cartQuantity,
      ),
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  const _RoundIconButton({
    required this.icon,
    required this.onTap,
    this.iconColor,
  });

  final IconData icon;
  final VoidCallback onTap;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kCardColor,
      elevation: 2,
      shadowColor: Colors.black.withValues(alpha: 0.08),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 42,
          height: 42,
          child: Icon(icon, color: iconColor ?? kTextColor, size: 22),
        ),
      ),
    );
  }
}

class _DetailBody extends StatelessWidget {
  const _DetailBody({
    required this.l10n,
    required this.product,
    required this.priceLine,
    required this.recommendations,
    required this.onOpenRelated,
    required this.showInlineCartCta,
    required this.mobilePriceAboveBottomBar,
    required this.isInCart,
    required this.cartQuantity,
    required this.cart,
  });

  final AppLocalizations l10n;
  final Product product;
  final String priceLine;
  final List<Product> recommendations;
  final void Function(Product) onOpenRelated;
  final bool showInlineCartCta;
  final bool mobilePriceAboveBottomBar;
  final bool isInCart;
  final int cartQuantity;
  final Cart cart;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            if (product.displayUnit.isNotEmpty)
              _InfoChip(
                icon: Icons.scale_rounded,
                label: product.displayUnit,
              ),
            _InfoChip(
              icon: Icons.verified_outlined,
              label: l10n.productFresh,
            ),
          ],
        ),
        const SizedBox(height: 14),
        Text(
          product.displayTitle,
          style: GoogleFonts.poppins(
            fontSize: 26,
            fontWeight: FontWeight.w700,
            color: kTextColor,
            height: 1.2,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            ...List.generate(
              5,
              (i) => Icon(
                i < 4 ? Icons.star_rounded : Icons.star_half_rounded,
                color: const Color(0xFFFFB300),
                size: 22,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '4.8',
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: kTextColor,
              ),
            ),
            Text(
              ' · ',
              style: GoogleFonts.poppins(color: kTextLight),
            ),
            Text(
              l10n.free,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: kPrimaryGreenDark,
              ),
            ),
          ],
        ),
        if (!mobilePriceAboveBottomBar) ...[
          const SizedBox(height: 20),
          Text(
            priceLine,
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: kPrimaryGreenDark,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 20),
        ],
        if (mobilePriceAboveBottomBar) const SizedBox(height: 20),
        _TrustStrip(l10n: l10n),
        const SizedBox(height: 28),
        Description(product: product),
        const SizedBox(height: 24),
        _OrganicHighlightCard(l10n: l10n),
        if (recommendations.isNotEmpty) ...[
          const SizedBox(height: 32),
          Text(
            l10n.productRecommendations,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: kTextColor,
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 168,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: recommendations.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, i) {
                final p = recommendations[i];
                return _RelatedProductCard(
                  product: p,
                  onTap: () => onOpenRelated(p),
                );
              },
            ),
          ),
        ],
        if (mobilePriceAboveBottomBar) ...[
          const SizedBox(height: 32),
          Text(
            priceLine,
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: kPrimaryGreenDark,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 12),
        ],
        if (showInlineCartCta) ...[
          const SizedBox(height: 36),
          isInCart
              ? _DesktopCartStepper(
                  cart: cart,
                  product: product,
                  quantity: cartQuantity,
                )
              : _PrimaryWideButton(
                  l10n: l10n,
                  onPressed: () {
                    cart.addItem(
                      product.id,
                      product.price,
                      product.title,
                      product.imageUrl,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(l10n.addedToCart)),
                    );
                  },
                ),
          const SizedBox(height: 24),
        ],
      ],
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: kSoftGreen.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kPrimaryGreen.withValues(alpha: 0.15)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: kPrimaryGreenDark),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: kPrimaryGreenDark,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _TrustStrip extends StatelessWidget {
  const _TrustStrip({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: kBackgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kDividerColor),
      ),
      child: Row(
        children: [
          Expanded(
            child: _TrustCell(
              icon: Icons.local_shipping_outlined,
              title: l10n.delivery,
              subtitle: l10n.free,
            ),
          ),
          Container(width: 1, height: 36, color: kDividerColor),
          Expanded(
            child: _TrustCell(
              icon: Icons.support_agent_rounded,
              title: l10n.help,
              subtitle: l10n.navHelp,
            ),
          ),
          Container(width: 1, height: 36, color: kDividerColor),
          Expanded(
            child: _TrustCell(
              icon: Icons.payments_outlined,
              title: l10n.checkout,
              subtitle: l10n.navPayment,
            ),
          ),
        ],
      ),
    );
  }
}

class _TrustCell extends StatelessWidget {
  const _TrustCell({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 22, color: kPrimaryGreen),
        const SizedBox(height: 6),
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: kTextColor,
          ),
        ),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.poppins(
            fontSize: 10,
            color: kTextSecondary,
          ),
        ),
      ],
    );
  }
}

class _OrganicHighlightCard extends StatelessWidget {
  const _OrganicHighlightCard({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            kSoftGreen.withValues(alpha: 0.55),
            kCardColor,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kDividerColor),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: kPrimaryGreen,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.eco_rounded, color: Colors.white, size: 26),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.organicTitle,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: kTextColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.organicSubtitle,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    height: 1.35,
                    color: kTextSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RelatedProductCard extends StatelessWidget {
  const _RelatedProductCard({
    required this.product,
    required this.onTap,
  });

  final Product product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Material(
      color: kCardColor,
      borderRadius: BorderRadius.circular(18),
      elevation: 2,
      shadowColor: Colors.black.withValues(alpha: 0.06),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: SizedBox(
          width: 132,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(18)),
                  child: Container(
                    color: kBackgroundColor,
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(
                      product.imageUrl,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.displayTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: kTextColor,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      l10n.priceCurrency(
                        _formatSumSpaced(product.price),
                      ),
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: kPrimaryGreenDark,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PrimaryWideButton extends StatelessWidget {
  const _PrimaryWideButton({
    required this.l10n,
    required this.onPressed,
  });

  final AppLocalizations l10n;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.shopping_bag_outlined, size: 22),
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

class _DesktopCartStepper extends StatelessWidget {
  const _DesktopCartStepper({
    required this.cart,
    required this.product,
    required this.quantity,
  });

  final Cart cart;
  final Product product;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: kSoftGreen,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kPrimaryGreen.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Material(
            color: kCardColor,
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(15),
            ),
            child: InkWell(
              onTap: () => cart.removeSingleItem(product.id),
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(15),
              ),
              child: SizedBox(
                width: 56,
                height: 56,
                child: Icon(
                  quantity == 1
                      ? Icons.delete_outline_rounded
                      : Icons.remove_rounded,
                  color: quantity == 1 ? kErrorRed : kPrimaryGreenDark,
                  size: 24,
                ),
              ),
            ),
          ),
          Expanded(
            child: Text(
              '$quantity',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: kPrimaryGreenDark,
              ),
            ),
          ),
          Material(
            color: kPrimaryGreen,
            borderRadius: const BorderRadius.horizontal(
              right: Radius.circular(15),
            ),
            child: InkWell(
              onTap: () => cart.addItem(
                product.id,
                product.price,
                product.title,
                product.imageUrl,
              ),
              borderRadius: const BorderRadius.horizontal(
                right: Radius.circular(15),
              ),
              child: const SizedBox(
                width: 56,
                height: 56,
                child: Icon(Icons.add_rounded, color: Colors.white, size: 24),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MobileCartBar extends StatelessWidget {
  const _MobileCartBar({
    required this.l10n,
    required this.product,
    required this.cart,
    required this.isInCart,
    required this.cartQuantity,
  });

  final AppLocalizations l10n;
  final Product product;
  final Cart cart;
  final bool isInCart;
  final int cartQuantity;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 12,
      shadowColor: Colors.black26,
      color: kCardColor,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
          child: isInCart
              ? SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: _MobileStepperCompact(
                    cart: cart,
                    product: product,
                    quantity: cartQuantity,
                  ),
                )
              : SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      cart.addItem(
                        product.id,
                        product.price,
                        product.title,
                        product.imageUrl,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(l10n.addedToCart)),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryGreen,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      l10n.addToCart,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

class _MobileStepperCompact extends StatelessWidget {
  const _MobileStepperCompact({
    required this.cart,
    required this.product,
    required this.quantity,
  });

  final Cart cart;
  final Product product;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kSoftGreen,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () => cart.removeSingleItem(product.id),
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(14)),
              child: Center(
                child: Icon(
                  quantity == 1
                      ? Icons.delete_outline_rounded
                      : Icons.remove_rounded,
                  color: quantity == 1 ? kErrorRed : kPrimaryGreenDark,
                  size: 22,
                ),
              ),
            ),
          ),
          Text(
            '$quantity',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: kPrimaryGreenDark,
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () => cart.addItem(
                product.id,
                product.price,
                product.title,
                product.imageUrl,
              ),
              borderRadius: const BorderRadius.horizontal(right: Radius.circular(14)),
              child: const Center(
                child: Icon(Icons.add_rounded, color: kPrimaryGreenDark, size: 22),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
