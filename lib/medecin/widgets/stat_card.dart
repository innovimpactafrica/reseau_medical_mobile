
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/HexColor.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final bool isNegative;
  final String? iconPath;        // Icône à droite (ligne du titre)
  final String? titleIconPath;   // Icône à gauche du titre

  const StatCard({
    Key? key,
    required this.title,
    required this.value,
    required this.subtitle,
    this.isNegative = false,
    this.iconPath,
    this.titleIconPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = isNegative ? Colors.red : Colors.green;
    final arrowIcon = isNegative ? Icons.arrow_downward : Icons.arrow_upward;

    return Container(
      width: double.infinity,
      height: 95,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ligne 1 : Icone + Titre à gauche, Icone à droite
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (titleIconPath != null) ...[
                SvgPicture.asset(
                  titleIconPath!,
                  width: 12,
                  height: 13,
                ),
                const SizedBox(width: 3),
              ],
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: HexColor('#64748B'),
                  ),
                ),
              ),
              if (iconPath != null)
                SvgPicture.asset(
                  iconPath!,
                  width: 12,
                  height: 13,
                ),
            ],
          ),

          const SizedBox(height: 4),

          // Ligne 2 : Valeur principale
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 4),

          // Ligne 3 : Flèche + Subtitle
          Row(
            children: [
              Icon(
                arrowIcon,
                size: 13,
                color: color,
              ),
              const SizedBox(width: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: color,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
