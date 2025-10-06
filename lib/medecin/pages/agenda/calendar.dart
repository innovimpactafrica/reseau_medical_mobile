import 'package:flutter/material.dart';
import 'package:rmelapp/medecin/pages/agenda/nouveau_rdv.dart';
import 'package:rmelapp/medecin/utils/HexColor.dart';
import 'agenda_list.dart'; // garde ton fichier existant

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime(2025, 7, 14);
  DateTime? _selectedDay = DateTime(2025, 7, 14);
  bool _showAgendaList = false;

  final Map<DateTime, List<Map<String, dynamic>>> _appointments = {
    DateTime(2025, 7, 14): [
      {
        "title": "Consultation avec Lamine Diop",
        "time": "09:00",
        "location": "Hopital Fann",
        "status": "Annulé",
        "statusColor": Color(0xFFF97316),
        "fullDate": "14/07/2025 - 09:00",
        "id": "1",
        "accent": null,
      }
    ],
    DateTime(2025, 7, 15): [
      {
        "title": "Consultation avec Marie Diop",
        "time": "10:00",
        "location": "Hopital Yoff",
        "status": "À venir",
        "statusColor": Color(0xFF3B82F6),
        "fullDate": "15/07/2025 - 10:00",
        "id": "2",
        "accent": Color(0xFFF59E0B), // left accent bar like capture
      },
      {
        "title": "Consultation avec Fama Sow",
        "time": "13:00",
        "location": "Hopital Yoff",
        "status": "Terminée",
        "statusColor": Color(0xFF10B981),
        "fullDate": "15/07/2025 - 13:00",
        "id": "3",
        "accent": null,
      }
    ],
  };

  String _getMonthYear(DateTime date) {
    const months = [
      '',
      'Janvier',
      'Février',
      'Mars',
      'Avril',
      'Mai',
      'Juin',
      'Juillet',
      'Août',
      'Septembre',
      'Octobre',
      'Novembre',
      'Décembre'
    ];
    return '${months[date.month]} ${date.year}';
  }

  String _getDayName(DateTime date) {
    const days = [
      'dimanche',
      'lundi',
      'mardi',
      'mercredi',
      'jeudi',
      'vendredi',
      'samedi'
    ];
    // date.weekday: 1..7 (Mon..Sun) so we map to 0..6 with (weekday % 7)
    return days[date.weekday % 7];
  }

  @override
  Widget build(BuildContext context) {
    final allEvents = _appointments.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    return Scaffold(
      backgroundColor: HexColor('#F2F5FA'),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [HexColor('#305579'), HexColor('#1C3752')],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 0,
        centerTitle: false,
        title: const Padding(
          padding: EdgeInsets.only(left: 16),
          child: Text(
            "Agenda",
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        actions: [
          _buildToggleButton("Calendrier", Icons.calendar_today, false),
          _buildToggleButton("Liste", Icons.menu, true),
          const SizedBox(width: 8),
        ],
      ),
      body: _showAgendaList
          ? const ListPage()
          : Column(
              children: [
                // White area with month and week selector
                Container(
                  color: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    children: [
                      _buildMonthNavigation(),
                      const SizedBox(height: 8),
                      _buildHorizontalWeekSelector(),
                      const SizedBox(height: 8),
                      // thin divider like capture
                      Container(height: 4, color: HexColor('#F3F4F6')),
                    ],
                  ),
                ),

                const SizedBox(height: 8),

                // Events list area
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: allEvents.length,
                    itemBuilder: (context, index) {
                      final date = allEvents[index].key;
                      final events = allEvents[index].value;
                      final dayLabel =
                          "${date.day} ${_capitalizeMonth(date.month)} ${_getDayName(date)}";

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Date header (ex: "14 juillet  vendredi")
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Text(
                              dayLabel,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                            ),
                          ),

                          // Events for that day
                          ...events.map((event) => _buildEventItem(event)).toList(),
                        ],
                      );
                    },
                  ),
                )
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // navigation as in your original code
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => NouveauRendezVousPage()),
          );
        },
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [HexColor('#2563EB'), HexColor('#1D4ED8')],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 8,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  // Helper to capitalize month name for the small day label
  String _capitalizeMonth(int month) {
    const months = [
      '',
      'janvier',
      'février',
      'mars',
      'avril',
      'mai',
      'juin',
      'juillet',
      'août',
      'septembre',
      'octobre',
      'novembre',
      'décembre'
    ];
    return months[month];
  }

  Widget _buildToggleButton(String label, IconData icon, bool isList) {
    final selected = _showAgendaList == isList;
    // On the capture, the selected toggle looks like a white pill with small red icon+label.
    return InkWell(
      onTap: () {
        setState(() {
          _showAgendaList = isList;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 16,
              color: selected ? HexColor('#B53C3A') : Colors.white,
            ),
            if (selected) ...[
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: HexColor('#B53C3A'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMonthNavigation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            setState(() {
              _focusedDay = _focusedDay.subtract(const Duration(days: 7));
            });
          },
          icon: const Icon(Icons.chevron_left, color: Color(0xFF374151)),
        ),
        Text(
          _getMonthYear(_focusedDay),
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF111827),
          ),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              _focusedDay = _focusedDay.add(const Duration(days: 7));
            });
          },
          icon: const Icon(Icons.chevron_right, color: Color(0xFF374151)),
        ),
      ],
    );
  }

  Widget _buildHorizontalWeekSelector() {
    final startOfWeek =
        _focusedDay.subtract(Duration(days: (_focusedDay.weekday % 7)));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(7, (index) {
        final currentDate = startOfWeek.add(Duration(days: index));
        final isSelected = _selectedDay != null &&
            currentDate.year == _selectedDay!.year &&
            currentDate.month == _selectedDay!.month &&
            currentDate.day == _selectedDay!.day;

        final dayNames = ['Dim', 'Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam'];

        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedDay = currentDate;
            });
          },
          child: Column(
            children: [
              Text(
                dayNames[index],
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF9CA3AF),
                ),
              ),
              const SizedBox(height: 6),
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: isSelected ? HexColor('#B53C3A') : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${currentDate.day}',
                    style: TextStyle(
                      color:
                          isSelected ? Colors.white : const Color(0xFF111827),
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildEventItem(Map<String, dynamic> event) {
    // Layout: left column with time + vertical line, right: card
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left time + timeline
          Column(
            children: [
              Text(
                event['time'],
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: HexColor('#333333B2'),
                ),
              ),
              const SizedBox(height: 6),
              // Vertical line
              Container(
                width: 1.5,
                height: 86,
                color: HexColor('#E6E6E6'),
              ),
            ],
          ),

          const SizedBox(width: 12),

          // Right: event card with optional left accent bar
          Expanded(
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  margin: EdgeInsets.only(left: event['accent'] != null ? 6 : 0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomRight: Radius.circular(8),
                      topRight: Radius.circular(4),
                      bottomLeft: Radius.circular(4),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title + status
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              event['title'],
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF111827),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: event['statusColor'],
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                event['status'],
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: event['statusColor'],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      // Date + location
                      Text(
                        '${event['fullDate']}, ${event['location']}',
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF6B7280),
                        ),
                      ),

                      // If event completed (Terminée) show Rejoindre button like capture
                      if (event['status'] == 'Terminée') ...[
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              // action to join (video call)
                            },
                            icon: const Icon(Icons.videocam,
                                color: Colors.white, size: 16),
                            label: const Text("Rejoindre"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: HexColor('#D97B7B'), // pinkish
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                // Left accent bar if exists
                if (event['accent'] != null)
                  Positioned(
                    left: 0,
                    top: 12,
                    bottom: 12,
                    child: Container(
                      width: 6,
                      decoration: BoxDecoration(
                        color: event['accent'],
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
