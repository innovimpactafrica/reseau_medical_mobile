import 'package:flutter/material.dart';
import '../utils/HexColor.dart';

class AppointmentCard extends StatelessWidget {
  final String initials;
  final String doctorName;
  final String specialty;
  final String date;
  final String time;
  final String location;
  final String status;

  const AppointmentCard({
    super.key,
    required this.initials,
    required this.doctorName,
    required this.specialty,
    required this.date,
    required this.time,
    required this.location,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final isPending = status == "En attente";
    final isConfirmed = status == "Confirmé";

    return Container(
      width: 360,
    
      margin: const EdgeInsets.only(bottom: 45),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: HexColor("#E5E7EB")),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          /// Ligne docteur + statut
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: HexColor("#E9EFFD"),
                    child: Text(
                      initials,
                      style: TextStyle(
                        color: HexColor("#2563EB"),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(doctorName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: HexColor("#111827"),
                          )),
                      Text(specialty,
                          style: TextStyle(
                            color: HexColor("#6B7280"),
                          )),
                    ],
                  ),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isConfirmed
                      ? HexColor("#DCFCE7")
                      : HexColor("#FEF9C3"),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: isConfirmed ? HexColor("#166534") : HexColor("#854D0E"),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          /// Détails RDV
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text("$date\n$location",
                    style: TextStyle(color: HexColor("#111827"))),
              ),
              Text(time,
                  style: TextStyle(
                    color: HexColor("#111827"),
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),

          const SizedBox(height: 16),

          /// Boutons actions selon statut
          if (isPending) ...[
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: HexColor("#2563EB"),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text("Confirmer",
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      backgroundColor: HexColor('#E9EFFD'),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      side: BorderSide(color: HexColor("#E9EFFD")),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text("Reporter",
                        style: TextStyle(color: HexColor("#2563EB"))),
                  ),
                ),
              ],
            ),
          ] else if (isConfirmed) ...[
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // ➜ Aller vers détails
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: HexColor("#2563EB"),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text("Détails",
                    style: TextStyle(color: HexColor("#FFFFFF"))),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
