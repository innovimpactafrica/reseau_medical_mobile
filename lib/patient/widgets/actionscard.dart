import 'package:flutter/material.dart';
import '../utils/HexColor.dart';

class QuickActionCard extends StatelessWidget {
  final String iconPath;
  final String label;

  const QuickActionCard({
    super.key,
    required this.iconPath,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 119.33,
      height: 94,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: HexColor("#FFFFFF")),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(iconPath, width: 41, height: 41),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: HexColor("#6B7280"),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
