import 'package:flutter/material.dart';

class AppointmentsSection extends StatelessWidget {
  const AppointmentsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Rendez-vous",
          style: TextStyle(
            color: Color(0xFF111827),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // ✅ Légendes
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  _Legend("A venir", "09", Color(0xFF1E40AF)), // bleu foncé
                  SizedBox(height: 8),
                  _Legend("Terminés", "12", Color(0xFF60A5FA)), // bleu clair
                  SizedBox(height: 8),
                  _Legend("Annulés", "02", Color(0xFFDC2626)), // rouge
                ],
              ),

              // ✅ Pie chart stylisé (factice comme dans la maquette)
              CustomPaint(
                size: Size(80, 80),
                painter: _PieChartPainter(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Legend extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _Legend(this.label, this.value, this.color);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        const SizedBox(width: 6),
        Text(value, style: TextStyle(color: color, fontWeight: FontWeight.w600)),
      ],
    );
  }
}

class _PieChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final radius = size.width / 2;
    final center = Offset(radius, radius);

    // Segment A venir
    paint.color = const Color(0xFF1E40AF);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -0.5, 1.5, true, paint);

    // Segment Terminés
    paint.color = const Color(0xFF60A5FA);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), 1.0, 3.5, true, paint);

    // Segment Annulés
    paint.color = const Color(0xFFDC2626);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), 4.5, 0.8, true, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
