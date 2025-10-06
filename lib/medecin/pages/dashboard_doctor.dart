import 'package:flutter/material.dart';
import 'package:rmelapp/medecin/pages/affiliation.dart';
import 'package:rmelapp/medecin/pages/patient.dart';
import 'package:rmelapp/medecin/utils/HexColor.dart';
import '../widgets/stat_card.dart';
import '../widgets/quick_action.dart';
import '../widgets/consultation_chart.dart';
import '../widgets/pathologie_chart.dart';
import '../widgets/appointment.dart';
import '../widgets/appointment_list.dart';
import 'agenda/calendar.dart';
import 'ordonnance/ordonnance_page.dart';
import 'messages/message.dart';
import 'profil/compte.dart';

class DashboardDoctor extends StatefulWidget {
  const DashboardDoctor({Key? key}) : super(key: key);

  @override
  _DashboardDoctorState createState() => _DashboardDoctorState();
}

class _DashboardDoctorState extends State<DashboardDoctor> {
  int _currentBottomIndex = 0;
  int _selectedTab = 0; // 0: Graphiques, 1: Rendez-vous

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar uniquement si on est sur l'Accueil (Dashboard)
      appBar: _currentBottomIndex == 0 ? _buildDashboardAppBar() : null,

      // Body
      body: _getBody(),

      // Bottom Navigation
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  // --- AppBar du Dashboard ---
  PreferredSizeWidget _buildDashboardAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
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
      title: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: HexColor('#E9EFFD'),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                "LN",
                style: TextStyle(
                  color: HexColor('#2563EB'),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Dr Ndiaye",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              Text(
                "Cardiologue",
                style: TextStyle(fontSize: 12, color: Colors.white70),
              ),
            ],
          ),
        ],
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 16),
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Icon(
              Icons.notifications_outlined,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }

  // --- Retourne le body selon l'onglet sélectionné ---
  Widget _getBody() {
    switch (_currentBottomIndex) {
      case 0:
        return _buildDashboardBody(); // Accueil / Dashboard
      case 1:
        return const CalendarPage(); // Agenda
      case 2:
        return const OrdonnancesPage(); // Ordonnances
      case 3:
        return const Message(); // Messages
      case 4:
        return const DocteurCompte(); // Profil
      default:
        return _buildDashboardBody();
    }
  }

  // --- Dashboard principal ---
  Widget _buildDashboardBody() {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF2F5FA),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildStatCards(),
            const SizedBox(height: 16),
            _buildQuickActions(),
            const SizedBox(height: 16),
            _buildTabs(),
            const SizedBox(height: 16),
            _buildTabContent(),
          ],
        ),
      ),
    );
  }

  // --- Stat Cards ---
  Widget _buildStatCards() {
    return Column(
      children: const [
        Row(
          children: [
            Expanded(
              child: StatCard(
                title: "Consultations",
                value: "5",
                subtitle: "3 réalisées, 2 à venir",
                iconPath: 'assets/icons/agend.svg',
                titleIconPath: 'assets/icons/plus.svg',
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: StatCard(
                title: "Ordonnances",
                value: "32",
                subtitle: "+8% ce mois",
                iconPath: 'assets/icons/fileo.svg',
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: StatCard(
                title: "Comptes rendus",
                value: "28",
                subtitle: "+5% ce mois",
                iconPath: 'assets/icons/cr.png',
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: StatCard(
                title: "Taux d'absence",
                value: "7%",
                subtitle: "-2% vs mois dernier",
                isNegative: true,
                iconPath: 'assets/icons/abs.svg',
              ),
            ),
          ],
        ),
      ],
    );
  }

  // --- Quick Actions ---
 // --- Quick Actions ---
Widget _buildQuickActions() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      QuickAction(
        iconPath: "assets/icons/patie.png",
        label: "Rendez-vous",
        onTap: () {
          setState(() {
            _currentBottomIndex = 1; // bascule sur l'onglet Agenda
            _selectedTab = 1;        // tab Rendez-vous actif dans dashboard (optionnel)
          });
        },
      ),
      QuickAction(
        iconPath: "assets/icons/dispo.png",
        label: "Disponibilités",
        onTap: () {
          
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const DisponibilitePage()),
          );
        },
      ),
      QuickAction(
        iconPath: "assets/icons/pat.png",
        label: "Patients",
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const PatientsPage()),
        ),
      ),
    ],
  );
}


  // --- Onglets Graphiques / Rendez-vous ---
  Widget _buildTabs() {
    return Row(
      children: [
        _TabButton(
          title: "Graphiques",
          index: 0,
          selectedIndex: _selectedTab,
          onTap: _onTabChanged,
        ),
        _TabButton(
          title: "Rendez-vous",
          index: 1,
          selectedIndex: _selectedTab,
          onTap: _onTabChanged,
        ),
      ],
    );
  }

  void _onTabChanged(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  Widget _buildTabContent() {
    return _selectedTab == 0
        ? Column(
            children: const [
              ConsultationChart(),
              SizedBox(height: 16),
              PathologyChart(),
              SizedBox(height: 16),
              AppointmentStatusChart(),
            ],
          )
        : AppointmentsList(
            onVoirTous: () {
              setState(() {
                _currentBottomIndex = 1; // Aller à Agenda
              });
            },
          );
  }

  // --- Bottom Navigation ---
  Widget _buildBottomNavigation() {
    final navItems = [
      NavItem(iconPath: 'assets/icons/home.png', label: "Accueil"),
      NavItem(iconPath: 'assets/icons/mage.png', label: "Agenda"),
      NavItem(iconPath: 'assets/icons/script.png', label: "Ordonnances"),
      NavItem(iconPath: 'assets/icons/mess.png', label: "Messages"),
      NavItem(iconPath: 'assets/icons/solar.png', label: "Profil"),
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, -2),
          )
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(navItems.length, (index) {
              final isSelected = _currentBottomIndex == index;
              return GestureDetector(
                onTap: () => setState(() => _currentBottomIndex = index),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      navItems[index].iconPath,
                      width: 22,
                      height: 22,
                      color:
                          isSelected ? HexColor('#B53C3A') : HexColor('#64748B'),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      navItems[index].label,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isSelected
                            ? HexColor('#B53C3A')
                            : HexColor('#64748B'),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

// --- Nav Item ---
class NavItem {
  final String iconPath;
  final String label;
  NavItem({required this.iconPath, required this.label});
}

// --- Tab Button Widget ---
class _TabButton extends StatelessWidget {
  final String title;
  final int index;
  final int selectedIndex;
  final Function(int) onTap;

  const _TabButton({
    required this.title,
    required this.index,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: isSelected ? HexColor('#3B82F6') : HexColor('#64748B'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
