import 'package:flutter/material.dart';

class PatientDetailPage extends StatelessWidget {
  final String name;
  final String lastVisit;

  const PatientDetailPage({
    Key? key,
    required this.name,
    required this.lastVisit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E4777),
        title: Text(
          name,
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Nom: $name",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 8),
                Text("Dernière consultation: $lastVisit",
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 20),
                const Text(
                  "Détails médicaux:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                    "Ici s’afficheront les informations médicales du patient..."),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
