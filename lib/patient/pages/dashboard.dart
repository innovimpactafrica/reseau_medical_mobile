import 'package:flutter/material.dart';
import 'package:rmelapp/patient/pages/choix_medecin.dart';
import '../utils/HexColor.dart';
import '../widgets/appointement.dart';
import '../widgets/actionscard.dart';

// Pages correspondantes
import 'rendez-vous/rdv_list.dart';
import 'ordonnances/ordonnance_page.dart';
import 'compte/compte_page.dart';

class DashboardPage extends StatefulWidget {
  final int initialIndex;
  const DashboardPage({super.key, this.initialIndex = 0});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late int _currentIndex;


  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex; // 🔹 on initialise avec l’index reçu
  }

  final List<Widget> _pages = const [
    DashboardHomeView(),
    MesRendezVousPage(),
    OrdonnancesPage(),
    MonComptePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#F9FAFB"),
      body: _pages[_currentIndex],

       /// ---- Bouton flottant ----
      floatingActionButton: Container(
  margin: const EdgeInsets.only(bottom: 65.0, right: 10.0), // 🔹 remonte et décale à droite
  child: FloatingActionButton(
    onPressed: () {
     Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ChoisirMedecinPage()),
      );
      // navigation vers la page de choix des médecins
    },
    backgroundColor: HexColor("#2563EB"),
    foregroundColor: Colors.white,
    shape: const CircleBorder(),
    child: const Icon(Icons.add, size: 28),
  ),
),
floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,

      /// ---- Bottom Navigation ----
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
        child: Container(
          padding: const EdgeInsets.symmetric(  horizontal: 12, vertical: 0.5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() => _currentIndex = index);
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedItemColor: HexColor("#285D90"),
            unselectedItemColor: HexColor("#9CA3AF"),
            showUnselectedLabels: true,
            items: const [
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage("assets/icons/home.png"), size: 26),
                label: "Accueil",
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage("assets/icons/mage.png"), size: 26),
                label: "Rendez-vous",
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage("assets/icons/script.png"), size: 26),
                label: "Ordonnances",
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage("assets/icons/solar.png"), size: 26),
                label: "Mon compte",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ---- Contenu Accueil ----
class DashboardHomeView extends StatelessWidget {
  const DashboardHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ---- Header ----
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset("assets/images/logo.png", height: 45),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: HexColor("#E9EFFD"),
                      radius: 20,
                      child: Text(
                        "MD",
                        style: TextStyle(
                          color: HexColor("#2563EB"),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Icon(Icons.notifications_none,
                        color: HexColor("#4B5563"), size: 28),
                  ],
                )
              ],
            ),
          ),

          /// ---- Bannière Bonjour ----
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [HexColor("#285D90"), HexColor("#B53C3A")],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Bonjour, Marie",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      )),
                  const SizedBox(height: 8),
                  Text("Comment allez-vous aujourd'hui ?",
                      style: TextStyle(color: HexColor("#FAFAFA"), fontSize: 14)),
                  const SizedBox(height: 16),

                  /// Champ recherche
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search, color: Colors.white),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Rechercher un médecin...",
                              hintStyle: TextStyle(color: Colors.white70),
                            ),
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          /// ---- Boutons rapides ----
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                QuickActionCard(
                  iconPath: "assets/icons/rdv.png",
                  label: "Rendez-vous",
                ),
                QuickActionCard(
                  iconPath: "assets/icons/ordonn.png",
                  label: "Ordonnances",
                ),
                QuickActionCard(
                  iconPath: "assets/icons/doc.png",
                  label: "Documents",
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          /// ---- Section Rendez-vous ----
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Rendez-vous",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: HexColor("#111827"),
                    )),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      Text("Tous",
                          style: TextStyle(
                            color: HexColor("#2563EB"),
                            fontWeight: FontWeight.w600,
                          )),
                      const SizedBox(width: 4),
                      Icon(Icons.arrow_forward_ios,
                          size: 14, color: HexColor("#2563EB")),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          /// ---- Liste de RDV scrollable horizontalement ----
          SizedBox(
            height: 250,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: const [
                AppointmentCard(
                  initials: "LD",
                  doctorName: "Dr. Lamine DIOP",
                  specialty: "Cardiologie",
                  date: "Jeudi 15 juin",
                  time: "10:30",
                  location: "Centre Médical Saint-Louis",
                  status: "En attente",
                ),
                SizedBox(width: 16),
                AppointmentCard(
                  initials: "AS",
                  doctorName: "Dr. Aminata Sow",
                  specialty: "Dermatologie",
                  date: "Jeudi 15 juin",
                  time: "14:45",
                  location: "Clinique des Almadies",
                  status: "Confirmé",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
