import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rmelapp/medecin/utils/HexColor.dart';
import '../widgets/quick_action.dart';
import '../widgets/consultation_chart.dart';
import '../widgets/pathologie_chart.dart';
import '../widgets/appointment.dart';
import '../widgets/appointment_list.dart';
import './affiliation.dart';
import './ordonnance/ordonnance_page.dart';
import './patient.dart';
import 'calendar.dart';

// -------------------- StatCard --------------------
class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final bool isNegative;
  final String? iconPath; // Icône à droite
  final String? titleIconPath; // Icône à côté du titre

  const StatCard({
    Key? key,
    required this.title,
    required this.value,
    required this.subtitle,
    this.isNegative = false,
    this.iconPath,
    this.titleIconPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = isNegative ? Colors.red : Colors.green;
    final arrowIcon = isNegative ? Icons.arrow_downward : Icons.arrow_upward;

    return Container(
      width: double.infinity,
      height: 100,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(arrowIcon, color: color, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87)),
                    if (titleIconPath != null) ...[
                      const SizedBox(width: 4),
                      SvgPicture.asset(titleIconPath!, width: 16, height: 16),
                    ]
                  ],
                ),
                const SizedBox(height: 6),
                Text(value,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                const Spacer(),
                Text(subtitle,
                    style: TextStyle(
                        fontSize: 12, color: color, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          if (iconPath != null) ...[
            SvgPicture.asset(
              iconPath!,
              width: 28,
              height: 28,
            ),
          ],
        ],
      ),
    );
  }
}

// -------------------- DashboardDoctor --------------------
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
      backgroundColor: HexColor('#F2F5FA'),

      // 👉 AppBar affiché uniquement si index = 0
      appBar: _currentBottomIndex == 0
          ? AppBar(
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
            )
          : null, // 🚀 Pas d’AppBar si autre page

      body: IndexedStack(
        index: _currentBottomIndex,
        children: [
          _buildDashboardContent(),
          const CalendarPage(),
          const OrdonnancesPage(),
          const MessagesPage(),
          const ProfilPage(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildDashboardContent() {
    return SafeArea(
      child: Column(
        children: [
          _buildStatCards(),
          _buildQuickActions(),
          _buildTabs(),
          Expanded(child: _buildTabContent()),
        ],
      ),
    );
  }

  // --- Stat Cards ---
  Widget _buildStatCards() {
    return Container(
      color: HexColor('#F2F5FA'),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: const [
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
          const SizedBox(height: 12),
          Row(
            children: const [
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
      ),
    );
  }

  // --- Quick Actions ---
  Widget _buildQuickActions() {
    return Container(
      color: HexColor('#F2F5FA'),
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          QuickAction(
            iconPath: "assets/icons/patie.png",
            label: "Rendez-vous",
            onTap: () {
    setState(() {
      _currentBottomIndex = 1; // Même index que l’onglet Agenda
    });
  },

          ),
          QuickAction(
            iconPath: "assets/icons/dispo.png",
            label: "Disponibilités",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const DisponibilitePage()),
            ),
          ),
          QuickAction(
            iconPath: "assets/icons/pat.png",
            label: "Patients",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => PatientsPage()),
            ),
          ),
        ],
      ),
    );
  }

  // --- Onglets Graphiques / Rendez-vous ---
  Widget _buildTabs() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: HexColor('#F1F5F9'),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
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
      ),
    );
  }

  void _onTabChanged(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  Widget _buildTabContent() {
    return Container(
      color: HexColor('#F8FAFC'),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: _selectedTab == 0
            ? Column(
                children: const [
                  ConsultationChart(),
                  SizedBox(height: 16),
                  PathologyChart(),
                  SizedBox(height: 16),
                  AppointmentStatusChart(),
                ],
              )
            : const AppointmentsList(),
      ),
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
                          isSelected ? HexColor('#EF4444') : HexColor('#64748B'),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      navItems[index].label,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: isSelected
                            ? HexColor('#EF4444')
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

// --- Classe NavItem ---
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

// --- Pages factices ---
class OrdonnancePage extends StatelessWidget {
  const OrdonnancePage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Page Ordonnances"));
  }
}

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Page Messages"));
  }
}

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Page Profil"));
  }
}
