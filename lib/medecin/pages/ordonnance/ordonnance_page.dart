import 'package:flutter/material.dart';
import 'package:rmelapp/medecin/pages/ordonnance/choix_patient.dart';
import '../../utils/HexColor.dart';
import 'details_pordonnance.dart';

class OrdonnancesPage extends StatefulWidget {
  const OrdonnancesPage({super.key});

  @override
  State<OrdonnancesPage> createState() => _OrdonnancesPageState();
}

class _OrdonnancesPageState extends State<OrdonnancesPage> {
  String selectedCategory = "Toutes";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#F9FAFB'),

      // ✅ Bouton flottant (à l’extérieur du Column)
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF1E40AF),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ChoisirPatient()),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ✅ Header bleu
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
            color: HexColor("#305579"),
            child: const Text(
              "Ordonnances",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),

          // ✅ Zone blanche en dessous
          Expanded(
            child: Container(
              width: double.infinity,
              color: Colors.white,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ✅ Barre de recherche
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search, color: Colors.grey),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText:
                                    "Rechercher un médecin, une spécialité...",
                                hintStyle: TextStyle(
                                  color: HexColor('#CCCCCC'),
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // ✅ Liste des ordonnances
                    _buildOrdonnanceCard(
                      context,
                      title: "Lamine Diop",
                      doctor: "2 médicaments",
                      date: "15 juin 2025",
                      size: "1.1 MB",
                      isNew: true,
                    ),
                    _buildOrdonnanceCard(
                      context,
                      title: "Amadou Diallo",
                      doctor: "2 médicaments",
                      date: "05 juin 2025",
                      size: "1.2 MB",
                    ),
                    _buildOrdonnanceCard(
                      context,
                      title: "Fatou Ndiaye",
                      doctor: "3 médicaments",
                      date: "28 mai 2025",
                      size: "1.5 MB",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ✅ Widget carte ordonnance
  Widget _buildOrdonnanceCard(
    BuildContext context, {
    required String title,
    required String doctor,
    required String date,
    required String size,
    bool isNew = false,
  }) {
    return GestureDetector(
      onTap: () {
        // ✅ Navigation vers la page de détails
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const OrdonnanceDetailPage(),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 5,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Row(
          children: [
            // ✅ Icône document
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: HexColor("#E6EEFF"),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Image.asset('assets/icons/files.png', height: 35),
            ),
            const SizedBox(width: 12),

            // ✅ Détails ordonnance
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      if (isNew)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: HexColor("#1EA438"),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            "Nouvelle",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    doctor,
                    style:
                        const TextStyle(color: Colors.black54, fontSize: 13),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "$date  •  $size",
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),

            // ✅ Bouton téléchargement
            IconButton(
              icon: Image.asset('assets/icons/tele.png', height: 24),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
