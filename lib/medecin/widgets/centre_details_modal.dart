import 'package:flutter/material.dart';
import 'package:rmelapp/medecin/utils/HexColor.dart';
import '../models/centre_modal.dart';
import 'edit_disponibilite_modal.dart';

class CentreDetailsModal extends StatefulWidget {
  final Centre centre;
  final VoidCallback onUpdate;

  const CentreDetailsModal({
    Key? key,
    required this.centre,
    required this.onUpdate,
  }) : super(key: key);

  @override
  State<CentreDetailsModal> createState() => _CentreDetailsModalState();
}

class _CentreDetailsModalState extends State<CentreDetailsModal> {
  void _openEditModal(Disponibilite dispo) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => EditDisponibiliteModal(
        disponibilite: dispo,
        onSave: () {
          widget.onUpdate();
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final centre = widget.centre;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: 20,
        left: 20,
        right: 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Barre en haut
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            // Titre + adresse
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F0FE),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Image.asset(
                    'assets/icons/afil.png'
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        centre.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        centre.address,
                        style: TextStyle(
                          color: HexColor('#6B7280'),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Disponibilités
            Column(
              children: centre.disponibilites.map((dispo) {
                return GestureDetector(
                  onTap: () => _openEditModal(dispo),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 14,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: HexColor('#DBEAFE')),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8F0FE),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child:  Icon(
                            Icons.access_time,
                            size: 20,
                            color: HexColor('#2563EB'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dispo.jour,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "${dispo.heureDebut} - ${dispo.heureFin}",
                              style:  TextStyle(
                                fontSize: 12,
                                color: HexColor('#6B7280'),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            dispo.dureeConsultation,
                            style:  TextStyle(
                              color: HexColor('#1E40AF'),
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 24),
            const Divider(height: 1),
            const SizedBox(height: 16),

            // Actif switch
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Actif",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(width: 10),
                Switch(
                  value: centre.active,
                  onChanged: (val) {
                    setState(() {
                      centre.active = val;
                    });
                    widget.onUpdate();
                  },
                  activeColor: Colors.white,
                  activeTrackColor: const Color(0xFF1E4777),
                ),
              ],
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
