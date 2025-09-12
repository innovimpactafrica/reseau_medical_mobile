import 'package:flutter/material.dart';
import '../utils/HexColor.dart';

class StatisticsCard extends StatelessWidget {
  const StatisticsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // ✅ Liste des stats
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              _StatLine("Patients absents", "02", HexColor('#E53E3E')), // rouge
              SizedBox(height: 8),
              _StatLine("Ordonnances",      "09", HexColor('#2B6CB0')), // bleu
              SizedBox(height: 8),
              _StatLine("Comptes rendus",   "05", HexColor('#FEB2B2')), // orange
              SizedBox(height: 8),
              _StatLine("Consultations",    "12", HexColor('#90CDF4')), // bleu clair
            ],
          ),

          // ✅ Mini bar chart (fixe comme sur la maquette)
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children:  [
              _Bar(height: 16, color: HexColor('#E53E3E')),
              SizedBox(width: 6),
              _Bar(height: 40, color: HexColor('#2B6CB0')),
              SizedBox(width: 6),
              _Bar(height: 28, color: HexColor('#FEB2B2')),
              SizedBox(width: 6),
              _Bar(height: 56, color: HexColor('#90CDF4')),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatLine extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatLine(this.label, this.value, this.color);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style:  TextStyle(
            color: HexColor('#5C738A'),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _Bar extends StatelessWidget {
  final double height;
  final Color color;

  const _Bar({required this.height, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(1),
      ),
    );
  }
}
