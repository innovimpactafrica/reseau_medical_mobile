import 'package:flutter/material.dart';
import '../../utils/HexColor.dart';

class RecapOrdonnancePage extends StatelessWidget {
  final String doctorName;
  final String clinic;
  final String patientName;
  final List<Map<String, dynamic>> medicaments;
  final String notes;

  const RecapOrdonnancePage({
    super.key,
    required this.doctorName,
    required this.clinic,
    required this.patientName,
    required this.medicaments,
    required this.notes,
  });

  @override
  Widget build(BuildContext context) {
    String today =
        "${DateTime.now().day} / ${DateTime.now().month} / ${DateTime.now().year}";

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Récapitulatif",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Médecin : $doctorName"),
            Text("Patient : $patientName"),
            Text("Date : $today"),
            Text("Centre de santé : $clinic"),
            const SizedBox(height: 20),

            const Text(
              "💊 Médicaments",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...medicaments.map((med) {
              return Text(
                  "${med["nom"]} ${med["dosage"]} • ${med["frequence"]} / ${med["duree"]}");
            }),

            const SizedBox(height: 20),
            const Text(
              "📝 Instructions particulières",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(notes.isEmpty ? "Aucune" : notes),

            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Modifier"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: HexColor("#305579"),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Ordonnance confirmée ✅")),
                    );
                  },
                  child: const Text("Confirmer"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
