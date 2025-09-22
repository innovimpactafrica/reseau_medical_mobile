import 'package:flutter/material.dart';
import 'package:rmelapp/medecin/pages/ordonnance/new_ordonnance.dart';
import '../../utils/HexColor.dart';

class ChoisirMedecinPage extends StatefulWidget {
  const ChoisirMedecinPage({super.key});

  @override
  State<ChoisirMedecinPage> createState() => _ChoisirMedecinPageState();
}

class _ChoisirMedecinPageState extends State<ChoisirMedecinPage> {
  

  

  final List<Map<String, String>> medecins = [
    {
      "initials": "LD",
      "name": "Lamine Diop",
      "age": "38ans",
      "sexe": "Homme"
    },
    {
      "initials": "AD",
      "name": "Amadou Diallo",
      "age": "45ans",
      "sexe": "Homme"
    },
    {
      "initials": "OS",
      "name": "Ousmane Sarr",
      "age": "62ans",
      "sexe": "Homme"
    },
    {
      "initials": "FN",
      "name": "Fatou Ndiaye",
      "age": "29ans",
      "sexe": "Femme"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#F9FAFB'),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ✅ Header bleu avec flèche retour
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(12, 60, 12, 20),
            color: HexColor("#305579"),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                const Expanded(
                  child: Text(
                    "Choisir un patient",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 48), // équilibre la flèche gauche
              ],
            ),
          ),

          // ✅ Contenu principal
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ✅ Barre de recherche
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: HexColor('#DBEAFE')),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      children:  [
                        Icon(Icons.search, color: Colors.grey),
                        SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText:
                                  "Rechercher un patient",
                              hintStyle: TextStyle(color:HexColor('#CCCCCC')),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),


                  // ✅ Liste des médecins
                 Column(
  children: medecins.map((med) {
    return _buildMedecinCard(
      initials: med["initials"]!,
      name: med["name"]!,
      specialite: med["specialite"]!,
      lieu: med["lieu"]!,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => NewOrdonnancePage(
              doctorName: med["name"]!,
              specialty: med["age"]!,
              clinic: med["sexe"]!,
              initials: med["initials"]!,
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ✅ Widget Card médecin
  Widget _buildMedecinCard({
    required String initials,
    required String name,
    required String specialite,
    required String lieu,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: HexColor("#DBEAFE")),
        ),
        child: Row(
          children: [
            // ✅ Avatar avec initiales
            CircleAvatar(
              radius: 22,
              backgroundColor: HexColor("#E9EFFD"),
              child: Text(
                initials,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: HexColor("#2563EB"),
                ),
              ),
            ),
            const SizedBox(width: 12),

            // ✅ Infos médecin
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "$specialite  •  $lieu",
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            // ✅ Disponible
            Text(
              "Disponible",
              style: TextStyle(
                color: HexColor("#16A34A"),
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

