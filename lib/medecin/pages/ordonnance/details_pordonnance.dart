import 'package:flutter/material.dart';
import '../../utils/HexColor.dart';
import 'detail_patient.dart';
class OrdonnanceDetailPage extends StatelessWidget {
  const OrdonnanceDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#F9FAFB"),
      appBar: AppBar(
        backgroundColor: HexColor("#305579"),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Amadou Diallo",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
    IconButton(
      icon: Image.asset('assets/icons/filepa.png'),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                const PatientDetailPage(),
          ),
        );
      },
    ),
  ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ----------- Section Détails -----------
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // TODO: Remplacer par ton icône asset
                      Image.asset('assets/icons/gg_info.svg', color: HexColor("#305579")),
                      const SizedBox(width: 8),
                      const Text(
                        "Détails",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: HexColor('#1EA438'),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          "Nouvelle",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildDetailRow("Medecin", "Dr. Ndiaye"),
                  _buildDetailRow("Patient", "Amadou Diallo"),
                  _buildDetailRow("Date", "15 Octobre 2025"),
                  _buildDetailRow("Centre de santé", "Pharmacie du centre"),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // ----------- Section Médicaments -----------
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // TODO: Remplacer par ton icône asset
                      Image.asset('assets/icons/mdi.svg', color: HexColor("#305579")),
                      const SizedBox(width: 8),
                      const Text(
                        "Médicaments",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildMedicationRow("Amlor 5mg", "1 cp par jour"),
                  _buildMedicationRow("Cozaar 50mg", "1 cp par jour"),
                  _buildMedicationRow("Moduretic", "1/2 cp par jour"),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // ----------- Section Instructions -----------
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // TODO: Remplacer par ton icône asset
                     Image.asset('assets/icons/gg_info.svg', color: HexColor("#305579")),
                      const SizedBox(width: 8),
                      const Text(
                        "Instructions particulières",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Prendre tous les médicaments le matin.\n"
                    "Contrôler la tension artérielle 2 fois par semaine et noter les résultats. "
                    "Revoir dans 1 mois.",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            
            // ----------- Bouton Télécharger -----------
            OutlinedButton.icon(
              onPressed: () {},
              icon: Image.asset('assets/icons/tele.png'),
              label:  Text(
                "Télécharger",
                style: TextStyle(
                  fontSize: 16,
                  color: HexColor('#5C738A'),
                  fontWeight: FontWeight.w500,
                ),
              ),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 55),
                side: BorderSide(color: Colors.grey.shade300),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style:  TextStyle(
              fontSize: 14,
              color: HexColor('#5C738A'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicationRow(String med, String dose) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(
            med,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const Spacer(),
          Text(
            dose,
            style:  TextStyle(
              fontSize: 14,
              color: HexColor('#5C738A'),
            ),
          ),
        ],
      ),
    );
  }
}
