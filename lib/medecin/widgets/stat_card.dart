import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rmelapp/medecin/utils/HexColor.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final bool isNegative;
  final String? iconPath;      // Icône à droite
  final String? titleIconPath; // Icône à gauche du subtitle

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
      width: 50,
      height: 100,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Flèche de tendance
        
          const SizedBox(width: 8),

          // Texte principal
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Titre
                Text(
                  title,
                  style:  TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: HexColor('#64748B')),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),

                // Valeur
                Text(
                  value,
                  style:  TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: HexColor('#1E293B')),
                ),
                const Spacer(),

                // Subtitle avec icône à gauche sur la même ligne
                Row(
                  children: [
                    if (titleIconPath != null) ...[
                      SvgPicture.asset(
                        titleIconPath!,
                        width: 12,
                        height: 13,
                      ),
                      const SizedBox(width: 4),
                    ],
                    Flexible(
                      child: Text(
                        subtitle,
                        style: TextStyle(
                            fontSize: 12,
                            color: color,
                            fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Icône à droite
          if (iconPath != null) ...[
            const SizedBox(width: 8),
            SvgPicture.asset(
              iconPath!,
              width: 14,
              height: 11,
            ),
          ],
        ],
      ),
    );
  }
}
