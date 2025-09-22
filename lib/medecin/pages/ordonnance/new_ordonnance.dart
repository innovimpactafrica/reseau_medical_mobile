import 'package:flutter/material.dart';
import '../../utils/HexColor.dart';
import 'recap_ordonnance.dart';

class NewOrdonnancePage extends StatefulWidget {
  final String doctorName;
  final String specialty;
  final String clinic;
  final String initials;

  const NewOrdonnancePage({
    super.key,
    required this.doctorName,
    required this.specialty,
    required this.clinic,
    required this.initials,
  });

  @override
  State<NewOrdonnancePage> createState() => _NewOrdonnancePageState();
}

class _NewOrdonnancePageState extends State<NewOrdonnancePage> {
  List<Map<String, dynamic>> medicaments = [
    {"nom": "", "dosage": "", "frequence": "", "duree": "", "instructions": ""},
  ];

  TextEditingController notesController = TextEditingController();

  // ✅ Aller à la page récapitulatif
  void _goToRecapPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RecapOrdonnancePage(
          doctorName: widget.doctorName,
          clinic: widget.clinic,
          patientName: "Amadou Diallo", // exemple, à rendre dynamique si besoin
          medicaments: medicaments,
          notes: notesController.text,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#F9FAFB"),
      body: Column(
        children: [
          // ✅ Header
          Container(
            padding: const EdgeInsets.fromLTRB(12, 50, 12, 20),
            color: HexColor("#305579"),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                const Expanded(
                  child: Text(
                    "Nouvelle ordonnance",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.white),
                  onPressed: _goToRecapPage,
                ),
              ],
            ),
          ),

          // ✅ Contenu
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Carte Patient
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: HexColor("#DBEAFE")),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundColor: HexColor("#E9EFFD"),
                          child: Text(
                            widget.initials,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: HexColor("#2563EB"),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.doctorName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                            Text("${widget.specialty} • ${widget.clinic}",
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.black54)),
                          ],
                        ),
                        const Spacer(),
                        Text("Disponible",
                            style: TextStyle(
                                color: HexColor("#16A34A"),
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Médicaments
                  Column(
                    children: List.generate(medicaments.length, (index) {
                      return _buildMedicamentForm(index);
                    }),
                  ),

                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text("Ajouter un autre médicament"),
                    onPressed: () {
                      setState(() {
                        medicaments.add({
                          "nom": "",
                          "dosage": "",
                          "frequence": "",
                          "duree": "",
                          "instructions": "",
                        });
                      });
                    },
                  ),
                  const SizedBox(height: 20),

                  // Notes supplémentaires
                  TextField(
                    controller: notesController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: "Notes supplémentaires",
                      hintText: "Instructions générales, recommandations, etc.",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Bouton enregistrer
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _goToRecapPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: HexColor("#305579"),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text("Enregistrer"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ✅ Formulaire médicament
  Widget _buildMedicamentForm(int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: HexColor("#DBEAFE")),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Titre + bouton supprimer
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Médicament ${index + 1}",
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              if (index > 0)
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.red),
                  onPressed: () {
                    setState(() {
                      medicaments.removeAt(index);
                    });
                  },
                ),
            ],
          ),
          TextField(
            decoration: const InputDecoration(labelText: "Nom du médicament"),
            onChanged: (val) => medicaments[index]["nom"] = val,
          ),
          TextField(
            decoration: const InputDecoration(labelText: "Dosage"),
            onChanged: (val) => medicaments[index]["dosage"] = val,
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(labelText: "Fréquence"),
                  onChanged: (val) => medicaments[index]["frequence"] = val,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(labelText: "Durée"),
                  onChanged: (val) => medicaments[index]["duree"] = val,
                ),
              ),
            ],
          ),
          TextField(
            decoration: const InputDecoration(
                labelText: "Instructions spéciales",
                hintText: "Ex: Avant de dormir, avec nourriture..."),
            onChanged: (val) => medicaments[index]["instructions"] = val,
          ),
        ],
      ),
    );
  }
}
