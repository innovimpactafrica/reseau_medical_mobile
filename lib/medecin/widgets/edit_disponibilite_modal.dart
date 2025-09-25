import 'package:flutter/material.dart';
import '../models/centre_modal.dart';

class EditDisponibiliteModal extends StatefulWidget {
  final Disponibilite disponibilite;
  final VoidCallback onSave;

  const EditDisponibiliteModal({
    Key? key,
    required this.disponibilite,
    required this.onSave,
  }) : super(key: key);

  @override
  State<EditDisponibiliteModal> createState() => _EditDisponibiliteModalState();
}

class _EditDisponibiliteModalState extends State<EditDisponibiliteModal> {
  late TextEditingController _startTimeController;
  late TextEditingController _endTimeController;

  late String selectedJour;
  late String selectedDuree;

  final List<String> jours = [
    'Lundi',
    'Mardi',
    'Mercredi',
    'Jeudi',
    'Vendredi',
    'Samedi',
    'Dimanche'
  ];

  final List<String> durees = [
    '15 min',
    '30 min',
    '45 min',
    '60 min',
  ];

  @override
  void initState() {
    super.initState();
    selectedJour = widget.disponibilite.jour;
    selectedDuree = durees.contains(widget.disponibilite.dureeConsultation)
        ? widget.disponibilite.dureeConsultation
        : durees.first;

    _startTimeController = TextEditingController(text: widget.disponibilite.heureDebut);
    _endTimeController = TextEditingController(text: widget.disponibilite.heureFin);
  }

  @override
  void dispose() {
    _startTimeController.dispose();
    _endTimeController.dispose();
    super.dispose();
  }

  Future<void> _selectTime(TextEditingController controller) async {
    final initialTime = TimeOfDay(
      hour: int.tryParse(controller.text.split(":")[0]) ?? 8,
      minute: int.tryParse(controller.text.split(":")[1]) ?? 0,
    );

    final picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (picked != null) {
      final formatted = picked.hour.toString().padLeft(2, '0') +
          ":" +
          picked.minute.toString().padLeft(2, '0');
      setState(() {
        controller.text = formatted;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            // Title + Close
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Modifier la disponibilité',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Centre de santé
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Centre de santé',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
            ),
            const SizedBox(height: 6),
            DropdownButtonFormField<String>(
              value: widget.disponibilite.centreName,
              onChanged: null,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              items: [
                DropdownMenuItem(
                  value: widget.disponibilite.centreName,
                  child: Text(widget.disponibilite.centreName),
                )
              ],
            ),
            const SizedBox(height: 16),

            // Jour
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Jour de la semaine',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
              ),
            ),
            const SizedBox(height: 6),
            DropdownButtonFormField<String>(
              value: selectedJour,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  selectedJour = value!;
                });
              },
              items: jours.map((jour) {
                return DropdownMenuItem(
                  value: jour,
                  child: Text(jour),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // Heure de début et fin
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Heure de début',
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: _startTimeController,
                        readOnly: true,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.access_time),
                            onPressed: () => _selectTime(_startTimeController),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Heure de fin',
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: _endTimeController,
                        readOnly: true,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.access_time),
                            onPressed: () => _selectTime(_endTimeController),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Durée de consultation
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Durée de consultation',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
              ),
            ),
            const SizedBox(height: 6),
            DropdownButtonFormField<String>(
              value: selectedDuree,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  selectedDuree = value!;
                });
              },
              items: durees.map((duree) {
                return DropdownMenuItem(
                  value: duree,
                  child: Text(duree),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Bouton Mettre à jour
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  widget.disponibilite.jour = selectedJour;
                  widget.disponibilite.heureDebut = _startTimeController.text;
                  widget.disponibilite.heureFin = _endTimeController.text;
                  widget.disponibilite.dureeConsultation = selectedDuree;

                  widget.onSave();
                  Navigator.pop(context); // Fermer après sauvegarde
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E4777),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Mettre à jour',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Bouton Supprimer (optionnel)
            TextButton(
              onPressed: () {
                // TODO: implémenter suppression si nécessaire
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
                minimumSize: const Size(double.infinity, 48),
              ),
              child: const Text('Supprimer'),
            ),
          ],
        ),
      ),
    );
  }
}
