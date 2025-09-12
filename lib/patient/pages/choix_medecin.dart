import 'package:flutter/material.dart';
import 'package:rmelapp/patient/pages/choix_date.dart';
import '../utils/HexColor.dart';

class ChoisirMedecinPage extends StatefulWidget {
  const ChoisirMedecinPage({super.key});

  @override
  State<ChoisirMedecinPage> createState() => _ChoisirMedecinPageState();
}

class _ChoisirMedecinPageState extends State<ChoisirMedecinPage> {
  String selectedCategory = "Toutes";

  final List<String> categories = [
    "Toutes",
    "Cardiologie",
    "Dermatologie",
    "Ophtalmologie",
    "Généraliste",
  ];

  final List<Map<String, String>> medecins = [
    {
      "initials": "LD",
      "name": "Dr. Lamine Diop",
      "specialite": "Cardiologie",
      "lieu": "Centre Médical Saint-Louis"
    },
    {
      "initials": "AS",
      "name": "Dr. Aminata Sow",
      "specialite": "Dermatologie",
      "lieu": "Clinique des Almadies"
    },
    {
      "initials": "OD",
      "name": "Dr. Ousmane Diallo",
      "specialite": "Ophtalmologie",
      "lieu": "Centre Médical Saint-Louis"
    },
    {
      "initials": "FN",
      "name": "Dr. Fatou Ndiaye",
      "specialite": "Généraliste",
      "lieu": "Centre Médical Saint-Louis"
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
                    "Choisir un médecin",
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
                                  "Rechercher un médecin, une spécialité...",
                              hintStyle: TextStyle(color:HexColor('#CCCCCC')),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // ✅ Onglets horizontaux scrollables
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: categories.map((cat) {
                        final bool isSelected = selectedCategory == cat;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedCategory = cat;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? HexColor("#DBEAFE")
                                    : HexColor('#F3F4F6'),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                cat,
                                style: TextStyle(
                                  color: isSelected
                                      ? HexColor("#1D4ED8")
                                      : HexColor('#374151'),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 20),

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
            builder: (_) => ChoixDate(
              doctorName: med["name"]!,
              specialty: med["specialite"]!,
              clinic: med["lieu"]!,
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

