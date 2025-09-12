import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/stat_card.dart';
import '../widgets/appointment.dart';
import '../widgets/today_appointment.dart';

class DashboardDoctor extends StatefulWidget {
  const DashboardDoctor({Key? key}) : super(key: key);

  @override
  _DashboardDoctorState createState() => _DashboardDoctorState();
}

class _DashboardDoctorState extends State<DashboardDoctor> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Dimensions pour positionner précisément la carte flottante
    final double headerHeight = 160;
    final double statsCardHeight = 120;
    final double statsCardTop = headerHeight - statsCardHeight / 2; // chevauchement
    final double contentTop = statsCardTop + statsCardHeight + 16;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SafeArea(
        child: Stack(
          children: [
            // Header (avec coins arrondis en bas)
            Positioned(
              top:-8,
              left: 0,
              right: 0,
              child: Container(
                height: headerHeight,
                decoration: const BoxDecoration(
                  color: Color(0xFF305579),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(1),
                    bottomRight: Radius.circular(1),
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(8, 1, 10, 50),
                child: Row(
                  children: [
                    // Avatar
                    Container(
                      width: 48,
                      height: 48,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.person,
                          color: Color(0xFF305579), size: 28),
                    ),
                    const SizedBox(width: 12),

                    // Nom & spécialité
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Dr Ndiaye",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Cardiologue",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),

                    // Notification
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.08),
                        shape: BoxShape.circle,
                      ),
                      child: Stack(
                        children: [
                          Center(
                            child: SvgPicture.asset(
                              "assets/icons/notification.svg",
                              width: 22,
                              height: 22,
                              color: Colors.white,
                            ),
                          ),
                          Positioned(
                            right: 8,
                            top: 8,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Carte statistiques (flottante, positionnée)
            Positioned(
              top: statsCardTop,
              left: 16,
              right: 16,
              child: StatisticsCard(
                
              ),
            ),

            // Contenu principal après la carte flottante
            Positioned(
              top: contentTop,
              left: 0,
              right: 0,
              bottom: 0,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SizedBox(height: 8),
                    AppointmentsSection(),
                    SizedBox(height: 24),
                    TodayAppointmentsSection(),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // Bottom navigation (restée dans ce fichier)
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildBottomNavigation() {
    final navItems = [
      {"icon": "assets/icons/home.svg", "label": "Accueil"},
      {"icon": "assets/icons/calendar.svg", "label": "Agenda"},
      {"icon": "assets/icons/patients.svg", "label": "Patients"},
      {"icon": "assets/icons/message.svg", "label": "Messagerie"},
      {"icon": "assets/icons/profile.svg", "label": "Profil"},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(navItems.length, (index) {
              final isSelected = _currentIndex == index;
              return GestureDetector(
                onTap: () => setState(() => _currentIndex = index),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // utilise Svg pour rester cohérent
                    SvgPicture.asset(
                      navItems[index]["icon"]!,
                      width: 22,
                      height: 22,
                      color: isSelected ? const Color(0xFFE53935) : const Color(0xFF6B7280),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      navItems[index]["label"]!,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: isSelected ? const Color(0xFFE53935) : const Color(0xFF6B7280),
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
