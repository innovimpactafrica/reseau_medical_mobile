import 'package:flutter/material.dart';
import '../utils/HexColor.dart';

class NouveauRendezVousPage extends StatefulWidget {
  const NouveauRendezVousPage({super.key});

  @override
  State<NouveauRendezVousPage> createState() => _NouveauRendezVousPageState();
}

class _NouveauRendezVousPageState extends State<NouveauRendezVousPage> {
  final _formKey = GlobalKey<FormState>();
  String? _patient, _motif, _notes, _centre;
  DateTime? _date;
  TimeOfDay? _start, _end;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nouveau Rendez-vous"),
        backgroundColor: HexColor("#2563EB"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLabel("Patient"),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                    hintText: "Nom du patient",
                  ),
                  onSaved: (v) => _patient = v,
                ),
                const SizedBox(height: 16),

                _buildLabel("Date"),
                TextFormField(
                  readOnly: true,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(),
                    hintText: "Choisir une date",
                  ),
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                    );
                    if (picked != null) setState(() => _date = picked);
                  },
                ),
                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel("Heure début"),
                          TextFormField(
                            readOnly: true,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.access_time),
                              border: OutlineInputBorder(),
                              hintText: "Début",
                            ),
                            onTap: () async {
                              final picked = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (picked != null) setState(() => _start = picked);
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
                          _buildLabel("Heure fin"),
                          TextFormField(
                            readOnly: true,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.access_time),
                              border: OutlineInputBorder(),
                              hintText: "Fin",
                            ),
                            onTap: () async {
                              final picked = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (picked != null) setState(() => _end = picked);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                _buildLabel("Centre de santé"),
                DropdownButtonFormField<String>(
                  items: ["Hôpital A", "Clinique B", "Cabinet C"]
                      .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                      .toList(),
                  onChanged: (v) => _centre = v,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                _buildLabel("Motif du rendez-vous"),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Ex: Consultation",
                  ),
                  onSaved: (v) => _motif = v,
                ),
                const SizedBox(height: 16),

                _buildLabel("Notes supplémentaires"),
                TextFormField(
                  maxLines: 3,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Ajouter une note...",
                  ),
                  onSaved: (v) => _notes = v,
                ),
                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: HexColor("#2563EB"),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    icon: const Icon(Icons.save, color: Colors.white),
                    label: const Text(
                      "Enregistrer",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        Navigator.pop(context);
                      }
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

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    );
  }
}
