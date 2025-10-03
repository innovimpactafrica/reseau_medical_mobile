import 'package:flutter/material.dart';
import '../../utils/HexColor.dart';
import 'calendar.dart'; // <-- Assure-toi du chemin correct vers CalendarPage

class NouveauRendezVousPage extends StatefulWidget {
  const NouveauRendezVousPage({super.key});

  @override
  State<NouveauRendezVousPage> createState() => _NouveauRendezVousPageState();
}

class _NouveauRendezVousPageState extends State<NouveauRendezVousPage> {
  final _dateController = TextEditingController();
  final _startController = TextEditingController();
  final _endController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    _startController.dispose();
    _endController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#FFFFFF"),
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
        centerTitle: false,
        title: const Padding(
          padding: EdgeInsets.only(left: 50),
          child: Text(
            "Nouveau rendez-vous",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(24),
        ),
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLabel("Patient"),
                TextFormField(
                  decoration: _inputDecoration(
                    hintText: "Rechercher un patient",
                    iconPath: 'assets/icons/user.png',
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),

                _buildLabel("Date"),
                TextFormField(
                  controller: _dateController,
                  readOnly: true,
                  decoration: _inputDecoration(
                    hintText: "jj/mm/aa",
                    iconPath: 'assets/icons/rdv.png',
                    fillColor: Colors.white,
                  ),
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                    );
                    if (picked != null) {
                      setState(() {
                        _dateController.text =
                            "${picked.day}/${picked.month}/${picked.year}";
                      });
                    }
                  },
                ),
                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel("Heure de début"),
                          TextFormField(
                            controller: _startController,
                            readOnly: true,
                            decoration: _inputDecoration(
                              hintText: "00:00",
                              iconPath: 'assets/icons/heure.png',
                              fillColor: Colors.white,
                            ),
                            onTap: () async {
                              final picked = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (picked != null) {
                                setState(() {
                                  _startController.text =
                                      picked.format(context);
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel("Heure de fin"),
                          TextFormField(
                            controller: _endController,
                            readOnly: true,
                            decoration: _inputDecoration(
                              hintText: "Fin",
                              iconPath: 'assets/icons/heure.png',
                              fillColor: Colors.white,
                            ),
                            onTap: () async {
                              final picked = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (picked != null) {
                                setState(() {
                                  _endController.text =
                                      picked.format(context);
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                _buildLabel("Centre de santé"),
                DropdownButtonFormField<String>(
                  items: ["Hôpital A", "Clinique B", "Cabinet C"]
                      .map((c) => DropdownMenuItem(
                          value: c,
                          child: Text(
                            c,
                          )))
                      .toList(),
                  onChanged: (v) {},
                  decoration: _inputDecoration(
                    hintText: "Sélectionner ",
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),

                _buildLabel("Motif du rendez-vous"),
                TextFormField(
                  decoration: _inputDecoration(
                    hintText: "Ex: Consultation",
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),

                _buildLabel("Notes supplémentaires"),
                SizedBox(
                  height: 80,
                  child: TextFormField(
                    maxLines: 3,
                    decoration: _inputDecoration(
                      hintText: "Entrez les notes...",
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: HexColor("#285D90"),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Enregistrer",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    onPressed: () {
                      // Redirection directe vers CalendarPage
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CalendarPage(),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hintText,
    String? iconPath,
    Color? fillColor,
  }) {
    return InputDecoration(
      filled: true,
      fillColor: fillColor ?? Colors.white,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: HexColor('#CBD5E1')),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: HexColor('#CBD5E1')),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: HexColor('#CBD5E1'), width: 1),
      ),
      hintText: hintText,
      hintStyle: TextStyle(color: HexColor('#ACB5BB')),
      suffixIcon: iconPath != null
          ? Padding(
              padding: const EdgeInsets.all(10),
              child: Image.asset(iconPath, width: 24, height: 24),
            )
          : null,
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: Colors.black,
        ),
      ),
    );
  }
}
