import 'package:flutter/material.dart';
import 'package:rmelapp/medecin/utils/HexColor.dart';
import 'calendar.dart';
import '../new_agenda.dart';

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
      backgroundColor: HexColor('#F2F5FA'),
      // Suppression de l'AppBar ici, à gérer dans la page parente

      body: Column(
        children: [
          Container(
            color: HexColor('#F2F5FA'),
            padding: const EdgeInsets.all(12), // un peu moins de padding
            child: TextField(
              decoration: InputDecoration(
                hintText: "Rechercher un rendez-vous",
                prefixIcon: const Icon(Icons.search, color: Color(0xFF9CA3AF)),
                hintStyle:  TextStyle(fontSize: 14, color: HexColor('#F2F5FA')),
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
                filled: true,
                fillColor: HexColor('#FFFFFF'),
                enabledBorder: OutlineInputBorder(
                  borderSide:  BorderSide(color:HexColor('#FFFFFF')),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFF1E40AF)),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
          _buildFilterTabs(),
          Expanded(child: _buildAppointmentsList()),
        ],
      ),
     floatingActionButton: FloatingActionButton(
        onPressed: () {
          
          // Action à définir
        },
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [HexColor('#2563EB'), HexColor('#1D4ED8')],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildFilterTabs() {
    return Container(
      height: 40, // réduit la hauteur
      color: HexColor('#F2F5FA'),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 15),
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isActive = filter == selectedFilter;
          return GestureDetector(
            onTap: () {
              setState(() => selectedFilter = filter);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), // moins de padding
              decoration: BoxDecoration(
                color: isActive ? HexColor('#B53C3A') : HexColor('#FFFFFF'),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                filter,
                style: TextStyle(
                  color: isActive ? Colors.white : HexColor('#305579'),
                  fontSize: 12, // police réduite
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
      padding: const EdgeInsets.all(12), // padding réduit
      itemCount: filteredAppointments.length,
      itemBuilder: (context, index) {
        final appointment = filteredAppointments[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: _buildListAppointmentCard(appointment),
        );
      },
    );
  }

  Widget _buildListAppointmentCard(Map<String, dynamic> a) {
    return Container(
      padding: const EdgeInsets.all(12), // padding réduit
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10), // coins un peu moins arrondis
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Titre + statut alignés sur la même ligne
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  a["title"],
                  style: const TextStyle(
                    fontSize: 14, // police un peu plus petite
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF111827),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(color: a["statusColor"], shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    a["status"],
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: a["statusColor"],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            "${a['fullDate']}, ${a['location']}",
            style: const TextStyle(fontSize: 13, color: Color(0xFF6B7280)),
          ),
          // Bouton "Rejoindre" uniquement si statut "Terminée", désactivé
          if (a["status"] == "Terminée") ...[
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 228, 170, 170), // gris désactivé
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: null, // désactivé
                icon: const Icon(Icons.videocam, size: 18, color: Colors.white70),
                label: const Text(
                  "Rejoindre",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white70,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
