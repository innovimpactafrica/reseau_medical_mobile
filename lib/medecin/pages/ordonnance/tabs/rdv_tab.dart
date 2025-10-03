import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rmelapp/medecin/utils/HexColor.dart';
import '../../agenda/nouveau_rdv.dart';

class RdvTab extends StatelessWidget {
  const RdvTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Container principal avec tout le contenu sauf le bouton
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Titre de la section
                 Text(
                  "Rendez-vous",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color:HexColor('#285D90'),
                  ),
                ),
                const SizedBox(height: 20),
                
                // Liste des rendez-vous avec traits verticaux
                _rdvItem(
                  "Consultation", 
                  "Sam. 13 septembre 2025, 10:00-12:00",
                  "assets/icons/frame5.svg",
                  showVerticalLine: true,
                ),
                _rdvItem(
                  "Suivi patient", 
                  "Lun. 15 septembre 2025, 14:00-15:00",
                  "assets/icons/frame5.svg",
                  showVerticalLine: true,
                ),
                _rdvItem(
                  "Consultation", 
                  "Lun. 15 septembre 2025, 14:00-15:00",
                  "assets/icons/frame5.svg",
                  showVerticalLine: true, // Dernier élément sans trait
                ),
              ],
            ),
          ),
        ),
        
        // Bouton en dehors du container
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context ,
                 MaterialPageRoute(
            builder: (context) => const NouveauRendezVousPage(),
          ),);
                
              },
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text(
              
                "Ajouter un rendez-vous",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: HexColor('#285D90'),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _rdvItem(String title, String datetime, String iconPath, {required bool showVerticalLine}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Colonne avec icône et trait vertical
        Column(
          children: [
            // Icône du calendrier
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF4A90E2).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child:  SvgPicture.asset(
                'assets/icons/frame5.svg',
                width: 24,
                height: 24,
                
              ),
              // Remplacez par ceci quand vous aurez vos assets :
              // child: Image.asset(
              //   iconPath,
              //   width: 24,
              //   height: 24,
              //   color: const Color(0xFF4A90E2),
              // ),
            ),
            
            // Trait vertical
            if (showVerticalLine)
              Container(
                width: 2,
                height: 30,
                margin: const EdgeInsets.symmetric(vertical: 8),
                color: const Color(0xFFE5E5E5),
              ),
          ],
        ),
        
        const SizedBox(width: 16),
        
        // Contenu texte
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  datetime,
                  style:  TextStyle(
                    fontSize: 14,
                    color: HexColor('#5C738A'),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }
}