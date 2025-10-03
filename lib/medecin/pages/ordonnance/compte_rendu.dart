import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../utils/HexColor.dart';
import 'package:rmelapp/medecin/utils/HexColor.dart';
import 'addcr.dart'; // <-- la page modale pour ajouter un CR

class CompteRenduPage extends StatefulWidget {
  const CompteRenduPage({Key? key}) : super(key: key);

  @override
  State<CompteRenduPage> createState() => _CompteRenduPageState();
}

class _CompteRenduPageState extends State<CompteRenduPage> {
  int selectedTabIndex = 0;
  final List<String> tabs = ["Tous", "Texte", "Audio", "Vidéo"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#F2F5FA'),

      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration:  BoxDecoration(
            gradient: LinearGradient(
              colors: [HexColor('#305579'),HexColor('#1C3752')],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Row(
          children: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
            const Expanded(
              child: Text(
                "Compte rendu",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 48), // pour équilibrer avec le bouton retour
          ],
        ),
      ),

      body: Column(
        children: [
          // Filtres directement sur fond gris clair
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              children: tabs.asMap().entries.map((entry) {
                int index = entry.key;
                String tab = entry.value;
                bool isSelected = index == selectedTabIndex;

                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => selectedTabIndex = index),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? HexColor('#B53C3A'): Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: isSelected
                            ? null
                            : Border.all(color: Colors.grey.shade400, width: 1),
                      ),
                      child: Text(
                        tab,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isSelected ? Colors.white : HexColor('#305579'),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // Liste des comptes rendus avec largeur réduite
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              children: [
                _buildCompteRenduItem(
                  "CR-1222",
                  "Consultation",
                  "12/05/2025 • txt",
                  "Texte",
                  HexColor('#6D9DC3'),
                  const Color(0xFFE3F2FD),
                ),
                _buildCompteRenduItem(
                  "CR-1223",
                  "Analyse",
                  "05/05/2023 • txt",
                  "Texte",
                  HexColor('#6D9DC3'),
                  const Color(0xFFE3F2FD),
                  showNonModifiable: true,
                ),
                _buildCompteRenduItem(
                  "CR-1224",
                  "Radio",
                  "15/05/2023 • mp4",
                  "Vidéo",
                  HexColor('#FF6B6B'),
                  const Color(0xFFFCE4EC),
                ),
                _buildCompteRenduItem(
                  "CR-1225",
                  "Prise de sang",
                  "20/04/2025 • mp3",
                  "Audio",
                  HexColor('#F29900'),
                  const Color(0xFFFFF3E0),
                  showNonModifiable: true,
                ),
              ],
            ),
          ),
        ],
      ),

      // Bouton flottant rond avec dégradé
      floatingActionButton: Container(
        width: 40,
        height: 40,
        decoration:  BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [HexColor('#2563EB'), HexColor('#1D4ED8')],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: IconButton(
          icon: const Icon(Icons.add, color: Colors.white, size: 22),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (context) => CompteRenduModal(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCompteRenduItem(
    String title,
    String subtitle,
    String date,
    String type,
    Color typeColor,
    Color typeBgColor,
    {bool showNonModifiable = false}
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20, 
        vertical: 8// ⬅️ Ajuste ici la largeur des cartes (plus tu augmentes, plus c’est étroit)
        
      ),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 14,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
               SvgPicture.asset('assets/icons/filem.svg'),
              const SizedBox(width: 8),
              Text(
                title,
                style:  TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: HexColor('#333333'),
                ),
              ),
              const Spacer(),
              
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: typeBgColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  type,
                  style: TextStyle(
                    color: typeColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style:  TextStyle(fontSize: 14, color:HexColor('#4B5563')),
          ),
          const SizedBox(height: 4),
          Text(
            date,
            style:  TextStyle(fontSize: 14, color: HexColor('#4B5563')),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (showNonModifiable)
                 Text(
                  "Non modifiable",
                  style: TextStyle(
                    color:HexColor('#FF6B6B'),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                )
              else
                const SizedBox.shrink(),
              TextButton(
                onPressed: () {},
                child:  Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Détails",
                      style: TextStyle(
                        color: HexColor('#2C7BE5'),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(Icons.chevron_right, color: HexColor('#2C7BE5'), size: 18),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
