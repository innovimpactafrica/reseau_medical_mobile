import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../utils/HexColor.dart';
import 'package:rmelapp/medecin/pages/ordonnance/ordonnance_page.dart'; // <-- point-virgule ajouté

class RecapOrdonnanceBottomSheet extends StatelessWidget {
  final String doctorName;
  final String clinic;
  final String patientName;
  final String date;
  final String notes;
  final List<Map<String, dynamic>> medicaments;

  const RecapOrdonnanceBottomSheet({
    super.key,
    required this.doctorName,
    required this.clinic,
    required this.patientName,
    required this.date,
    required this.notes,
    required this.medicaments,
  });

  void _showSuccessMessage(BuildContext context) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 100,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: AnimatedOpacity(
            opacity: 1.0,
            duration: const Duration(milliseconds: 300),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: HexColor("#D4F0D6"),
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset('assets/icons/check.png'),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Ordonnance envoyée",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "L'ordonnance a été envoyée à $patientName",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    overlay?.insert(overlayEntry);
 Future.delayed(const Duration(seconds: 2), () {
    overlayEntry.remove();
    // Ici on indexe la page Ordonnance
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const OrdonnancesPage()),
    );
  });
}
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Récapitulatif",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black87),
                ),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close, color: Colors.black54),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Détails
            _buildSection(
              icon: 'assets/icons/gg_info.svg',
              title: 'Détails',
              children: [
                _buildInfoRow("Médecin", doctorName),
                _buildInfoRow("Patient", patientName),
                _buildInfoRow("Date", date),
                _buildInfoRow("Centre de santé", clinic),
              ],
            ),
            const SizedBox(height: 16),

            // Médicaments
            _buildSection(
              icon: 'assets/icons/mdi.svg',
              title: 'Médicaments',
              children: medicaments.map((med) {
                return _buildInfoRow(
                  "${med['nom']} ${med['dosage']}",
                  "${med['frequence']} • ${med['duree']}",
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // Instructions
            _buildSection(
              icon: 'assets/icons/gg_info.svg',
              title: 'Instructions particulières',
              children: [
                Text(
                  notes.isNotEmpty ? notes : "Aucune instruction particulière",
                  style: const TextStyle(
                      color: Colors.black54, fontSize: 14, height: 1.4),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Boutons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: HexColor("#305579")),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(
                      "Modifier",
                      style: TextStyle(
                        color: HexColor("#305579"),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _showSuccessMessage(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: HexColor("#305579"),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      "Confirmer",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String icon,
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(icon,
                  color: HexColor("#305579"), width: 20, height: 20),
              const SizedBox(width: 8),
              Text(title,
                  style:
                      const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87)),
          const Spacer(),
          Flexible(
            child: Text(value,
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 14, color: HexColor("#5C738A"))),
          ),
        ],
      ),
    );
  }
}
