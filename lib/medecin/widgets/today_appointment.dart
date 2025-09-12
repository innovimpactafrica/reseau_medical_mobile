import 'package:flutter/material.dart';

class TodayAppointmentsSection extends StatelessWidget {
  const TodayAppointmentsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final appointments = [
      {"title": "Consultation avec Marie Dubois", "time": "14:00 - 15:00"},
      {"title": "Suivi patient avec Jean Martin", "time": "16:00 - 17:00"},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Rendez-vous du jour",
          style: TextStyle(
            color: Color(0xFF111827),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Column(
          children: appointments.map((rdv) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  // ✅ Icône calendrier depuis assets
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Image.asset("assets/icons/cal.png", width: 20, height: 20, color: const Color(0xFF374151)),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // ✅ Texte
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        rdv["title"]!,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF111827),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        rdv["time"]!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
