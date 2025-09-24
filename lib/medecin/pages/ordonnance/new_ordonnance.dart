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

  final List<String> frequenceOptions = [
    "1 fois/jour",
    "2 fois/jour",
    "3 fois/jour",
  ];

  final List<String> dureeOptions = [
    "3 jours",
    "7 jours",
    "14 jours",
  ];

  // Aller à la page récapitulatif
  void _goToRecapPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RecapOrdonnancePage(
          doctorName: widget.doctorName,
          clinic: widget.clinic,
          patientName: widget.doctorName,
          medicaments: medicaments,
          notes: notesController.text,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#F2F5FA"),
      body: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.fromLTRB(12, 50, 12, 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [HexColor("#305579"), HexColor("#173047")],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
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

          // Contenu
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                          radius: 20,
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

                  // Titre section
                   Text(
                    "Médicaments",
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold, color: HexColor('#111827')),
                  ),
                  const SizedBox(height: 10),

                  // Médicaments
                  Column(
                    children: List.generate(medicaments.length, (index) {
                      return _buildMedicamentForm(index);
                    }),
                  ),
                  const SizedBox(height: 12),

                  // Bouton ajouter médicament
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: HexColor("#DBEAFE"),
                      side: BorderSide(color: HexColor("#9CB8DA")),
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    icon: Icon(Icons.add, color: HexColor("#305579")),
                    label: Text(
                      "Ajouter un autre médicament",
                      style: TextStyle(color: HexColor("#285D90")),
                    ),
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
                  const Text(
                    "Notes supplémentaires",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: notesController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: "Instructions générales, recommandations, etc.",
                      filled: true,
                      fillColor: Colors.white,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#CBD5E1")),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#305579")),
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
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text("Enregistrer",
                          style: TextStyle(fontSize: 16, color: Colors.white)),
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

  // Formulaire médicament corrigé
  Widget _buildMedicamentForm(int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white, // Fond blanc
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
          const SizedBox(height: 20),

          // Nom
          const Text("Nom du médicament", style: TextStyle(fontWeight: FontWeight.w500)),
          const SizedBox(height: 4),
          TextField(
            decoration: InputDecoration(
              hintText: "Saisir (autocomplète)",
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onChanged: (val) => medicaments[index]["nom"] = val,
          ),
          const SizedBox(height: 20),

          // Dosage
          const Text("Dosage", style: TextStyle(fontWeight: FontWeight.w500)),
          const SizedBox(height: 4),
          TextField(
            decoration: InputDecoration(
              hintText: "Saisir",
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onChanged: (val) => medicaments[index]["dosage"] = val,
          ),
          const SizedBox(height: 20),

          // Fréquence et Durée
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Fréquence", style: TextStyle(fontWeight: FontWeight.w500)),
                    const SizedBox(height: 4),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        hintText: "Selectionner",
                        isDense: true,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      value: medicaments[index]["frequence"].isNotEmpty
                          ? medicaments[index]["frequence"]
                          : null,
                      items: frequenceOptions
                          .map((f) => DropdownMenuItem(value: f, child: Text(f)))
                          .toList(),
                      onChanged: (val) =>
                          setState(() => medicaments[index]["frequence"] = val ?? ""),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Durée", style: TextStyle(fontWeight: FontWeight.w500)),
                    const SizedBox(height: 4),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        hintText: "Selectionner",
                        isDense: true,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      value: medicaments[index]["duree"].isNotEmpty
                          ? medicaments[index]["duree"]
                          : null,
                      items: dureeOptions
                          .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                          .toList(),
                      onChanged: (val) =>
                          setState(() => medicaments[index]["duree"] = val ?? ""),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Instructions
          const Text("Instructions spéciales", style: TextStyle(fontWeight: FontWeight.w500)),
          const SizedBox(height: 4),
          TextField(
            decoration: InputDecoration(
              hintText: "Ex: Prendre avec de la nourriture, avant de dormir, etc.",
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 25),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onChanged: (val) => medicaments[index]["instructions"] = val,
          ),
        ],
      ),
    );
  }
}
