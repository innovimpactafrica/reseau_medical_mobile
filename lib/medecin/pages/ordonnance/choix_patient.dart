import 'package:flutter/material.dart';
import 'package:rmelapp/medecin/pages/ordonnance/new_ordonnance.dart';
import '../../utils/HexColor.dart';

class ChoisirPatient extends StatefulWidget {
  const ChoisirPatient({super.key});

  @override
  State<ChoisirPatient> createState() => _ChoisirPatientState();
}

class _ChoisirPatientState extends State<ChoisirPatient> {
  final List<Map<String, String>> patients = [
    {
      "initials": "LD",
      "name": "Lamine Diop",
      "age": "38 ans",
      "sexe": "Homme",
    },
    {
      "initials": "AD",
      "name": "Amadou Diallo",
      "age": "45 ans",
      "sexe": "Homme",
    },
    {
      "initials": "OS",
      "name": "Ousmane Sarr",
      "age": "62 ans",
      "sexe": "Homme",
    },
    {
      "initials": "FN",
      "name": "Fatou Ndiaye",
      "age": "29 ans",
      "sexe": "Femme",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#F9FAFB'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header bleu
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(12, 60, 12, 20),
            color: HexColor("#305579"),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context); // ← Retour correct
                  },
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
                const SizedBox(width: 48),
              ],
            ),
          ),

          // Contenu principal
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Barre de recherche
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: HexColor('#DBEAFE')),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search, color: Colors.grey),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Rechercher un patient",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Liste patients
                  Column(
                    children: patients.map((pat) {
                      return _buildPatientCard(
                        initials: pat["initials"]!,
                        name: pat["name"]!,
                        age: pat["age"]!,
                        sexe: pat["sexe"]!,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => NewOrdonnancePage(
                                doctorName: "Dr. Ndiaye",
                                specialty: "Cardiologue",
                                clinic: "Clinique Pasteur",
                                initials: "DN", // Initiales du médecin
                                patientName: pat["name"]!,
                                patientInitials: pat["initials"]!,
                                patientDetails:
                                    "${pat["sexe"]!} • ${pat["age"]!}",
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

  // Card patient
  Widget _buildPatientCard({
    required String initials,
    required String name,
    required String age,
    required String sexe,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: HexColor("#DBEAFE")),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: HexColor("#E9EFFD"),
              child: Text(
                initials,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: HexColor("#2563EB"),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nom + Disponible
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        "Disponible",
                        style: TextStyle(
                          color: HexColor("#16A34A"),
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "$age  •  $sexe",
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
