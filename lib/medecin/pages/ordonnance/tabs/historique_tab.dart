import 'package:flutter/material.dart';
import 'package:rmelapp/medecin/pages/ordonnance/addcr.dart';
import 'package:rmelapp/medecin/utils/HexColor.dart';
import '../addcr.dart';
import '../compte_rendu.dart';

// Couleurs réutilisées
final Color blueDark = const Color(0xFF2C3E5F);
final Color redActive = const Color(0xFFD81B60);
final Color blueSectionTitle = const Color(0xFF2196F3);
final Color blueLight = const Color(0xFF64B5F6);

class HistoriqueTab extends StatelessWidget {
  const HistoriqueTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // --- Antécédents médicaux ---
          _historiqueSection(
            title: "Antécédents médicaux",
            iconPath: "assets/icons/medic.png",
            action: "Modifier",
            children: [
              _medicalItem("Octobre 2022", "Diagnostic d'hypertension", "Tension artérielle 150/95 mmHg"),
              _medicalItem("Mars 2021", "Appendicectomie", "Intervention sans complications"),
              _medicalItem("Janvier 2020", "Fracture du poignet droit", "Suite à une chute, plâtre pendant 6 semaines"),
            ],
          ),
          const SizedBox(height: 16),

          // --- Antécédents familiaux ---
          _historiqueSection(
            title: "Antécédents familiaux",
            iconPath: "assets/icons/antec.png",
            action: "Modifier",
            children: [
              _familyItem("Père", "Hypertension artérielle, Diabète type 2", "65 ans"),
              _familyItem("Mère", "Cancer du sein (rémission)", "62 ans"),
              _familyItem("Frère", "Asthme", "42 ans"),
            ],
          ),
          const SizedBox(height: 16),

          // --- Historique des consultations ---
          _historiqueSection(
            title: "Historique des consultations",
            iconPath: "assets/icons/histor.png",
            action: "Ajouter",
            children: [
              _consultationItem(
                "15 juin 2025",
                "Dr. Lamine Diop",
                "Patiente se présente pour son suivi trimestriel d’hypertension. "
                "Tension artérielle sous contrôle avec le traitement actuel. "
                "Pas d’effets secondaires signalés. Maintien du traitement actuel.",
              ),
              _consultationItem(
                "15 juin 2025",
                "Dr. Lamine Diop",
                "Patiente se présente pour son suivi trimestriel d’hypertension. "
                "Tension artérielle sous contrôle avec le traitement actuel. "
                "Pas d’effets secondaires signalés. Maintien du traitement actuel.",
              ),
            ],
          ),
          const SizedBox(height: 20),

          // --- Boutons ---
          _buttonPrimary(context, "Créer un compte rendu", "assets/icons/fileedit.png"),
          const SizedBox(height: 8),
          _buttonSecondary(context, "Listez les comptes rendus", "assets/icons/rendu.png"),
        ],
      ),
    );
  }

  // Section générique avec icônes
  Widget _historiqueSection({
    required String title,
    required String iconPath,
    required String action,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              children: [
                Image.asset(iconPath, width: 20, height: 20),
                const SizedBox(width: 8),
                Text(title, style: TextStyle(color: HexColor('#285D90'), fontWeight: FontWeight.w600, fontSize: 15)),
              ],
            ),
            Text(action, style: TextStyle(color: HexColor('#285D90'), fontWeight: FontWeight.w600, fontSize: 14)),
          ]),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _medicalItem(String date, String title, String desc) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: HexColor('#E5E7EB')),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(date, style: TextStyle(color: HexColor('#111827'), fontSize: 15, fontWeight: FontWeight.w500)),
            Text(title, style: TextStyle(color: HexColor('#285D90'), fontSize: 14.4)),
          ],
        ),
        const SizedBox(height: 6),
        Text(desc, style: TextStyle(fontSize: 14, color: HexColor('#374151'))),
      ]),
    );
  }

  Widget _familyItem(String role, String maladie, String age) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(role, style: TextStyle(color: HexColor('#111827'), fontSize: 16.45, fontWeight: FontWeight.w600)),
            Text(age, style: TextStyle(fontSize: 14, color: HexColor('#6B7280'))),
          ],
        ),
        const SizedBox(height: 4),
        Text(maladie, style: TextStyle(fontSize: 14, color: HexColor('#374151'))),
      ]),
    );
  }

  Widget _consultationItem(String date, String doctor, String desc) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset("assets/icons/cons.png", width: 18, height: 18),
                const SizedBox(width: 6),
                Text(date, style: TextStyle(color: HexColor('#111827'), fontSize: 16, fontWeight: FontWeight.w600)),
              ],
            ),
            Text(doctor, style: TextStyle(fontSize: 14, color: HexColor('#6B7280'))),
          ],
        ),
        const SizedBox(height: 8),
        Text(desc, style: TextStyle(fontSize: 14, color: HexColor('#374151'))),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset('assets/icons/ecris.png', width: 20, height: 20),
            const SizedBox(width: 12),
            Image.asset('assets/icons/print.png', width: 20, height: 20),
            const SizedBox(width: 12),
            Image.asset('assets/icons/share.png', width: 20, height: 20),
          ],
        ),
      ]),
    );
  }

  // Bouton primaire → affiche une fenêtre modale
  // Bouton primaire → affiche CompteRenduModal
Widget _buttonPrimary(BuildContext context, String text, String iconPath) {
  return ElevatedButton.icon(
    onPressed: () {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true, // permet de faire un modal plein écran si besoin
        backgroundColor: Colors.transparent, // pour arrondir les bords via ton widget
        builder: (context) => CompteRenduModal(),
      );
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: HexColor('#285D90'),
      foregroundColor: Colors.white,
      minimumSize: const Size(double.infinity, 48),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    icon: Image.asset(iconPath, width: 20, height: 20, color: Colors.white),
    label: Text(text, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
  );
}


  // Bouton secondaire → navigation vers page CompteRenduPage
  Widget _buttonSecondary(BuildContext context, String text, String iconPath) {
    return OutlinedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CompteRenduPage()),
        );
      },
      style: OutlinedButton.styleFrom(
        foregroundColor: HexColor('#B53C3A'),
        side: BorderSide(color: HexColor('#DADADA'), width: 1.5),
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      icon: Image.asset(iconPath, width: 20, height: 20, color: HexColor('#B53C3A')),
      label: Text(text, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
    );
  }
}

