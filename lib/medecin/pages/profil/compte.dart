import 'package:flutter/material.dart';
import 'package:rmelapp/medecin/pages/affiliation.dart';
import '../../utils/HexColor.dart';
import 'info_personnel.dart';

class DocteurCompte extends StatefulWidget {
  const DocteurCompte({super.key});

  @override
  State<DocteurCompte> createState() => _DocteurCompteState();
}

class _DocteurCompteState extends State<DocteurCompte> {
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#F5F7FA'),
      body: Stack(
        children: [
          // 🟦 Header bleu
          Container(
            height: 150,
            width: double.infinity,
            color: HexColor('#305579'),
            padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
            alignment: Alignment.topLeft,
            child: const Text(
              'Mon compte',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          // 🤍 Container blanc qui chevauche le header
          Positioned(
            top: 110,
            left: 20,
            right: 20,
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height - 130,
                ),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Avatar
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: HexColor('#E5E7EB'),
                      ),
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Nom
                    Text(
                      'Dr Lamine Ndiaye',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: HexColor('#1F2937'),
                      ),
                    ),
                    const SizedBox(height: 4),
                    
                    // Spécialité
                    Text(
                      'Cardiologue',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: HexColor('#9CA3AF'),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Informations personnelles
                    _buildOptionItem(
                      icon: Icons.person_outline,
                      iconColor: HexColor('#2563EB'),
                      bgColor: HexColor('#EFF6FF'),
                      title: 'Informations personnelles',
                      trailing: Icon(Icons.chevron_right,
                          color: HexColor('#9CA3AF'), size: 24),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const InformationsPersonnellesPage(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 8),

                    // Affiliations
                    _buildOptionItem(
                      icon: Icons.business_outlined,
                      iconColor: HexColor('#2563EB'),
                      bgColor: HexColor('#EFF6FF'),
                      title: 'Affiliations',
                      trailing: Icon(Icons.chevron_right,
                          color: HexColor('#9CA3AF'), size: 24),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DisponibilitePage(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 8),

                    // Notifications
                    _buildOptionItem(
                      icon: Icons.notifications_none,
                      iconColor: HexColor('#2563EB'),
                      bgColor: HexColor('#EFF6FF'),
                      title: 'Notifications',
                      trailing: Transform.scale(
                        scale: 0.85,
                        child: Switch(
                          value: notificationsEnabled,
                          activeColor: HexColor('#2563EB'),
                          onChanged: (v) =>
                              setState(() => notificationsEnabled = v),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Déconnexion
                    _buildOptionItem(
                      icon: Icons.logout,
                      iconColor: HexColor('#EF4444'),
                      bgColor: HexColor('#FEF2F2'),
                      title: 'Se déconnecter',
                      titleColor: HexColor('#EF4444'),
                      onTap: () => _showLogoutConfirm(context),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionItem({
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required String title,
    Color? titleColor,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: bgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: titleColor ?? HexColor('#1F2937'),
                ),
              ),
            ),
            if (trailing != null) trailing,
          ],
        ),
      ),
    );
  }

  void _showLogoutConfirm(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Se déconnecter',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        content: const Text('Voulez-vous vraiment vous déconnecter ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(
              'Annuler',
              style: TextStyle(color: HexColor('#6B7280')),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: HexColor('#305579'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              Navigator.of(ctx).pop();
              // TODO: Implémenter la déconnexion
            },
            child: const Text('Se déconnecter'),
          ),
        ],
      ),
    );
  }
}