import 'package:flutter/material.dart';
import '../utils/HexColor.dart';
import 'agenda_list.dart';
import 'nouveau_rdv.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  void _goBack() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    Color gold = HexColor("#FFD700");
    Color darkBlue = HexColor("#1E3A8A");

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: gold,
        elevation: 0,
        toolbarHeight: 60,
        automaticallyImplyLeading: false,
        flexibleSpace: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                // Bouton retour
                GestureDetector(
                  onTap: _goBack,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),

                // Titre centré
                Expanded(
                  child: Center(
                    child: Text(
                      "Mes Rendez-vous",
                      style: TextStyle(
                        color: darkBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),

                // Icône calendrier
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CalendarPage()),
                    );
                  },
                  child: const Icon(Icons.calendar_today,
                      color: Colors.white, size: 22),
                ),
                const SizedBox(width: 12),

                // Icône menu (3 barres)
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AgendaListPage()),
                    );
                  },
                  child: Icon(Icons.menu, color: darkBlue, size: 24),
                ),
              ],
            ),
          ),
        ),
      ),

      // Exemple de contenu
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Text(
            "Ici ton calendrier / agenda",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
        ),
      ),

      // Bouton flottant
      floatingActionButton: FloatingActionButton(
        backgroundColor: HexColor("#2563EB"),
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const NouveauRendezVousPage()),
          );
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }
}
