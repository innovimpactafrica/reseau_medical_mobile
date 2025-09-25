import 'package:flutter/material.dart';

class AddDisponibiliteModal extends StatefulWidget {
  final String centreName;
  final void Function(String jour, String heureDebut, String heureFin, String dureeConsultation) onSave;
  final VoidCallback onCancel;

  const AddDisponibiliteModal({
    Key? key,
    required this.centreName,
    required this.onSave,
    required this.onCancel,
  }) : super(key: key);

  @override
  State<AddDisponibiliteModal> createState() => _AddDisponibiliteModalState();
}

class _AddDisponibiliteModalState extends State<AddDisponibiliteModal> {
  late TextEditingController _startTimeController;
  late TextEditingController _endTimeController;

  String selectedJour = 'Lundi';
  String selectedDuree = '15 min';

  final List<String> jours = [
    'Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi', 'Dimanche'
  ];

  final List<String> durees = [
    '15 min', '30 min', '45 min', '60 min',
  ];

  @override
  void initState() {
    super.initState();
    _startTimeController = TextEditingController(text: '08:00');
    _endTimeController = TextEditingController(text: '12:00');
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
      final formatted = picked.hour.toString().padLeft(2, '0') + ":" + picked.minute.toString().padLeft(2, '0');
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
                  'Ajouter une disponibilité',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: widget.onCancel,
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Centre (non modifiable)
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Centre de santé',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
              ),
            ),
            const SizedBox(height: 6),
            DropdownButtonFormField<String>(
              value: widget.centreName,
              onChanged: null,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              items: [
                DropdownMenuItem(
                  value: widget.centreName,
                  child: Text(widget.centreName),
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
              items: jours.map((jour) => DropdownMenuItem(value: jour, child: Text(jour))).toList(),
            ),

            const SizedBox(height: 16),

            // Heures début & fin
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
              items: durees.map((duree) => DropdownMenuItem(value: duree, child: Text(duree))).toList(),
            ),

            const SizedBox(height: 24),

            // Bouton Annuler
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: widget.onCancel,
                child: const Text('Annuler'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                  minimumSize: const Size(double.infinity, 48),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Bouton Enregistrer
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  widget.onSave(
                    selectedJour,
                    _startTimeController.text,
                    _endTimeController.text,
                    selectedDuree,
                  );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E4777),
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: const Text('Enregistrer', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
