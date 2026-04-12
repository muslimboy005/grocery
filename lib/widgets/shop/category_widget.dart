import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app/l10n/app_localizations.dart';
import 'package:grocery_app/model/category.dart';
import 'package:grocery_app/util/responsive.dart';
import 'package:grocery_app/util/shopping_colors.dart';

/// Matches [ProductWidget] card chrome (main shop grid).
const Color _kCategoryCardBg = Color(0xFFF0F0F4);

class CategoryWidget extends StatelessWidget {
  final Category? category;
  final Function? onTap;

  const CategoryWidget({Key? key, this.category, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isMobile = Responsive.isMobile(context);
    final radius = isMobile ? 20.0 : 22.0;
    final horizontalPad = isMobile ? 12.0 : 14.0;
    final bottomPad = isMobile ? 12.0 : 14.0;
    final titleSize = isMobile ? 13.0 : 14.0;
    final subtitleSize = isMobile ? 12.0 : 12.5;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onTap!(category!.id),
        borderRadius: BorderRadius.circular(radius),
        child: Container(
          decoration: BoxDecoration(
            color: _kCategoryCardBg,
            borderRadius: BorderRadius.circular(radius),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: isMobile ? 14 : 18,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
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
                        borderRadius: BorderRadius.vertical(top: Radius.circular(radius)),
                        child: Image.asset(
                          category!.imageUrl,
                          fit: BoxFit.fill,
                          alignment: Alignment.center,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(horizontalPad, 6, horizontalPad, bottomPad),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category!.title.replaceAll('\n', ' '),
                      style: GoogleFonts.poppins(
                        fontSize: titleSize,
                        fontWeight: FontWeight.w600,
                        color: kTextColor,
                        height: 1.25,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _getSubtitle(context, category!.title),
                      style: GoogleFonts.poppins(
                        fontSize: subtitleSize,
                        fontWeight: FontWeight.w400,
                        color: kTextLight,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: isMobile ? 10 : 12),
                    Container(
                      height: isMobile ? 40 : 44,
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
                      alignment: Alignment.center,
                      child: Text(
                        l10n.seeAll,
                        style: GoogleFonts.poppins(
                          fontSize: isMobile ? 13 : 14,
                          fontWeight: FontWeight.w700,
                          color: kTextColor,
                        ),
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

  String _getSubtitle(BuildContext context, String title) {
    final l10n = AppLocalizations.of(context)!;
    final t = title.toLowerCase();
    if (t.contains('meva')) return l10n.categorySubFruit;
    if (t.contains('non')) return l10n.categorySubBread;
    if (t.contains('ichimlik')) return l10n.categorySubDrink;
    if (t.contains('sut') || t.contains('tuxum')) return l10n.categorySubDairy;
    if (t.contains('go\'sht')) return l10n.categorySubMeat;
    return l10n.categorySubDefault;
  }
}
