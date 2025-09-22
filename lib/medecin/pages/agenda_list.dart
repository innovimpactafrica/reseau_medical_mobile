import 'package:flutter/material.dart';
import 'calendar.dart';
import 'new_agenda.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  String selectedFilter = "Toutes";
  final List<String> filters = ["Toutes", "À venir", "Terminées", "Annulées"];

  final List<Map<String, dynamic>> appointments = [
    {
      "title": "Consultation avec Lamine Diop",
      "date": DateTime(2025, 7, 14),
      "time": "15:00",
      "location": "Hôpital Fann",
      "status": "À venir",
      "statusColor": Color(0xFF3B82F6),
      "fullDate": "14/07/2025 - 15:00",
    },
    {
      "title": "Consultation avec Marie Diop",
      "date": DateTime(2025, 7, 15),
      "time": "10:00",
      "location": "Hôpital Yoff",
      "status": "Terminée",
      "statusColor": Color(0xFF10B981),
      "fullDate": "15/07/2025 - 10:00",
    },
    {
      "title": "Consultation avec Fama Sow",
      "date": DateTime(2025, 7, 15),
      "time": "15:00",
      "location": "Hôpital Yoff",
      "status": "Annulée",
      "statusColor": Color(0xFFF97316),
      "fullDate": "15/07/2025 - 15:00",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E40AF),
        elevation: 0,
        centerTitle: true, // Centre le titre
        title: const Text(
          "Agenda",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildToggleButton("Calendrier", false, Icons.calendar_today),
                const SizedBox(width: 8),
                _buildToggleButton("Liste", true, Icons.list),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Rechercher un rendez-vous",
                prefixIcon: const Icon(Icons.search, color: Color(0xFF9CA3AF)),
                hintStyle: const TextStyle(fontSize: 14, color: Color(0xFF9CA3AF)),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                filled: true,
                fillColor: const Color(0xFFF9FAFB),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFF1E40AF)),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          _buildFilterTabs(),
          Expanded(child: _buildAppointmentsList()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF1E40AF),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NouveauRendezVousPage()),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildToggleButton(String label, bool isActive, IconData icon) {
    return GestureDetector(
      onTap: () {
        if (label == "Calendrier") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const CalendarPage()),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            Icon(icon, size: 14, color: isActive ? const Color(0xFFEF4444) : Colors.white),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isActive ? const Color(0xFFEF4444) : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterTabs() {
    return Container(
      height: 50,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isActive = filter == selectedFilter;
          return GestureDetector(
            onTap: () {
              setState(() => selectedFilter = filter);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isActive ? const Color(0xFFEF4444) : const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                filter,
                style: TextStyle(
                  color: isActive ? Colors.white : const Color(0xFF374151),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAppointmentsList() {
    final filteredAppointments = selectedFilter == "Toutes"
        ? appointments
        : appointments.where((a) => a["status"] == selectedFilter).toList();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredAppointments.length,
      itemBuilder: (context, index) {
        final appointment = filteredAppointments[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildListAppointmentCard(appointment),
        );
      },
    );
  }

  Widget _buildListAppointmentCard(Map<String, dynamic> a) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12), // Coins plus arrondis
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status Row
          Row(
            children: [
              Container(
                width: 10, // Taille plus visible du point
                height: 10,
                decoration: BoxDecoration(color: a["statusColor"], shape: BoxShape.circle),
              ),
              const SizedBox(width: 10),
              Text(
                a["status"],
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: a["statusColor"],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Title
          Text(
            a["title"],
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF111827),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "${a['fullDate']}, ${a['location']}",
            style: const TextStyle(fontSize: 15, color: Color(0xFF6B7280)),
          ),
          // "Rejoindre" button uniquement si le statut est "Terminée"
          if (a["status"] == "Terminée") ...[
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEF4444),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  // Action pour rejoindre (à définir)
                },
                icon: const Icon(Icons.videocam, size: 20, color: Colors.white),
                label: const Text(
                  "Rejoindre",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
