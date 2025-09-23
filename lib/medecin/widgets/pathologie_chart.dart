import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PathologyChart extends StatelessWidget {
  const PathologyChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
          Row(
            children: [
              Icon(
                Icons.bar_chart,
                size: 16,
                color: const Color(0xFF3B82F6),
              ),
              const SizedBox(width: 8),
              const Text(
                "Répartition par pathologie",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Color(0xFF1F2937),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 26,
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 3,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: const Color(0xFFF1F5F9),
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: 6,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFF9CA3AF),
                          ),
                        );
                      },
                    ),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        const labels = ['Hypertension', 'Diabète', 'Asthme', 'Cardio.', 'Autres'];
                        if (value.toInt() >= 0 && value.toInt() < labels.length) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              labels[value.toInt()],
                              style: const TextStyle(
                                fontSize: 10,
                                color: Color(0xFF9CA3AF),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          );
                        }
                        return const Text('');
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                barGroups: [
                  BarChartGroupData(
                    x: 0,
                    barRods: [
                      BarChartRodData(
                        toY: 24,
                        color: const Color(0xFF3B82F6),
                        width: 15,
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                      )
                    ],
                  ),
                  BarChartGroupData(
                    x: 1,
                    barRods: [
                      BarChartRodData(
                        toY: 18,
                        color: const Color(0xFF10B981),
                        width: 15,
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                      )
                    ],
                  ),
                  BarChartGroupData(
                    x: 2,
                    barRods: [
                      BarChartRodData(
                        toY: 12,
                        color: const Color(0xFFF59E0B),
                        width: 15,
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                      )
                    ],
                  ),
                  BarChartGroupData(
                    x: 3,
                    barRods: [
                      BarChartRodData(
                        toY: 8,
                        color: const Color(0xFFEF4444),
                        width: 15,
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                      )
                    ],
                  ),
                  BarChartGroupData(
                    x: 4,
                    barRods: [
                      BarChartRodData(
                        toY: 14,
                        color: const Color(0xFF8B5CF6),
                        width: 15,
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}