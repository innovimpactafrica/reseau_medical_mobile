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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#F2F5FA'),

      // ✅ Bouton flottant
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => ChoisirPatient()),
          );
        },
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [HexColor('#2563EB'), HexColor('#1D4ED8')],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),

      // ✅ AppBar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [HexColor('#305579'), HexColor('#1C3752')],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 0,
        title: const Text(
          "Ordonnances",
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // ✅ Contenu
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ✅ Barre de recherche
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Rechercher une ordonnance",
                prefixIcon: const Icon(Icons.search, color: Color(0xFF9CA3AF)),
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: HexColor('#9CA3AF'),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: HexColor('#E5E7EB')),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFF1E40AF)),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // ✅ Liste ordonnances
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const OrdonnanceDetailPage(),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.015),
              blurRadius: 3,
              offset: const Offset(0, 1),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Haut
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/icons/files.png',
                  height: 35,
                  width: 35,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
                if (isNew)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    decoration: BoxDecoration(
                      color: HexColor("#1EA438"),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "Nouvelle",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 4),

            // ✅ Médicaments
            Padding(
              padding: const EdgeInsets.only(left: 32),
              child: Text(
                doctor,
                style: TextStyle(
                  color: HexColor('#6B7280'),
                  fontSize: 14,
                ),
              ),
            ),

            const SizedBox(height: 6),

            // ✅ Bas
            Row(
              children: [
                Expanded(
                  child: Text(
                    "$date  •  $size",
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ),
                IconButton(
                  icon: Image.asset(
                    'assets/icons/tele.png',
                    height: 20,
                    width: 20,
                  ),
                  onPressed: () {
                    // Télécharger
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
