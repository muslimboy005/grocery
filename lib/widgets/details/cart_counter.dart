import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app/util/shopping_colors.dart';

class CartCounter extends StatefulWidget {
  @override
  _CartCounterState createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  int numOfItems = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kBackgroundColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildButton(
            icon: Icons.remove_rounded,
            onTap: () {
              if (numOfItems > 1) {
                setState(() => numOfItems--);
              }
            },
          ),
          Container(
            width: 44,
            alignment: Alignment.center,
            child: Text(
              numOfItems.toString().padLeft(2, "0"),
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: kTextColor,
              ),
            ),
          ),
          _buildButton(
            icon: Icons.add_rounded,
            onTap: () => setState(() => numOfItems++),
            isPrimary: true,
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required IconData icon,
    required VoidCallback onTap,
    bool isPrimary = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isPrimary ? kPrimaryGreen : kCardColor,
          borderRadius: BorderRadius.circular(12),
          border: isPrimary ? null : Border.all(color: kDividerColor),
        ),
        child: Icon(
          icon,
          color: isPrimary ? Colors.white : kTextColor,
          size: 20,
        ),
      ),
    );
  }
}
