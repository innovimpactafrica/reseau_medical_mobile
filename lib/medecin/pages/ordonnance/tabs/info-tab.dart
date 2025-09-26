import 'package:flutter/material.dart';
import '../../../utils/HexColor.dart';

class InfoTab extends StatelessWidget {
  const InfoTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _infoSection("Informations personnelles", [
            _infoRow("Date de naissance", "10/10/1960"),
            _infoRow("Sexe", "Masculin"),
            _infoRow("Adresse", "Sacré Cœur"),
             _infoRow("Maladie", "Grossesse"),
          ]),
          const SizedBox(height: 16),
          _infoSection("Informations administratives", [
            _infoRow("Numero dossier", "ID: 123456"),
            _infoRow("Couverture sociale", "Lorem"),
          ]),
          const SizedBox(height: 16),
          _infoSection("Informations médicales", [
            
          ]),
        ],
      ),
    );
  }

  Widget _infoSection(String title, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title,
            style: TextStyle(color: HexColor('#285D90'), fontWeight: FontWeight.w700, fontSize: 18)),
        const SizedBox(height: 20),
        ...children,
      ]),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: HexColor('#212121'))),
          Text(value, style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15, color: HexColor('#5C738A'))),
        ],
      ),
    );
  }
}
