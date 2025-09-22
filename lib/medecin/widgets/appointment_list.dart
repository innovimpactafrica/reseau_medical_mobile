import 'package:flutter/material.dart';

class AppointmentsList extends StatelessWidget {
  const AppointmentsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appointments = [
      {
        "time": "10:00",
        "name": "Marie Sène",
        "status": "Confirmé",
        "subtitle": "Aujourd'hui • Suivi Hypertension",
        "statusColor": const Color(0xFF10B981),
      },
      {
        "time": "11:30",
        "name": "Amadou Diallo",
        "status": "En attente",
        "subtitle": "Aujourd'hui • Suivi Diabète",
        "statusColor": const Color(0xFFF59E0B),
      },
      {
        "time": "09:15",
        "name": "Fatou Ndiaye",
        "status": "Planifié",
        "subtitle": "Demain • Consultation Asthme",
        "statusColor": const Color(0xFF3B82F6),
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Prochains rendez-vous",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Color(0xFF1F2937),
                  ),
                ),
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3B82F6),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
          ...appointments.asMap().entries.map((entry) {
            int index = entry.key;
            Map<String, dynamic> appointment = entry.value;
            bool isLast = index == appointments.length - 1;
            
            return Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              decoration: BoxDecoration(
                border: isLast 
                    ? null 
                    : const Border(
                        bottom: BorderSide(
                          color: Color(0xFFF1F5F9),
                          width: 1,
                        ),
                      ),
              ),
              child: Row(
                children: [
                  // Barre colorée à gauche + heure
                  Column(
                    children: [
                      Container(
                        width: 3,
                        height: 40,
                        decoration: BoxDecoration(
                          color: appointment["statusColor"] as Color,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Text(
                    appointment["time"]!,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appointment["name"]!,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          appointment["subtitle"]!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: (appointment["statusColor"] as Color).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      appointment["status"]!,
                      style: TextStyle(
                        color: appointment["statusColor"] as Color,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Voir tous les rendez-vous",
                  style: TextStyle(
                    color: const Color(0xFF3B82F6),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: const Color(0xFF3B82F6),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}