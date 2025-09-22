import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rmelapp/medecin/utils/HexColor.dart';

class QuickAction extends StatelessWidget {
  final String iconPath;
  final String label;
  final VoidCallback onTap;

  const QuickAction({
    Key? key,
    required this.iconPath,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 110,
        height: 80,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: HexColor('#FFFFFF'),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icône
            Expanded(
              child: Center(
                child: iconPath.endsWith('.svg')
                    ? SvgPicture.asset(
                        iconPath,
                        width: 40,
                        height: 40,
                        // Supprimer la couleur si ton SVG est coloré
                        // color: HexColor('#1D4ED8'), 
                      )
                    : Image.asset(
                        iconPath,
                        width: 40,
                        height: 40,
                      ),
              ),
            ),
            const SizedBox(height: 4),
            // Texte à l'intérieur
            Text(
              label,
              style:  TextStyle(
                fontSize: 12,
                color: HexColor('#6B7280'),
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
