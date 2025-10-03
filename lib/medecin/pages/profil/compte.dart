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
    final double headerHeight = 200;
    final double whiteCardTop = 100;

    return Scaffold(
      backgroundColor: HexColor('#F5F7FA'),
      body: Stack(
        children: [
          // 🟦 Header bleu
          Container(
            height: headerHeight,
            width: double.infinity,
            color: HexColor('#305579'),
            padding: const EdgeInsets.only(top: 60),
            child: const Center(
              child: Text(
                'Mon compte',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),

          // 🩶 Fond gris arrondi derrière le container blanc
          Positioned(
            top: whiteCardTop + 40,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: HexColor('#F5F7FA'),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
            ),
          ),

          // 🤍 Container blanc principal
          Positioned(
            top: whiteCardTop,
            left: 16,
            right: 16,
            bottom: 16,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(20, 28, 20, 24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 15,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Avatar
                          Container(
                            width: 90,
                            height: 90,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: HexColor('#E0E6ED'),
                                width: 3,
                              ),
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/icons/avatar.png',
                                fit: BoxFit.cover,
                                width: 84,
                                height: 84,
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            'Dr Lamine Ndiaye',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: HexColor('#2F3542'),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Cardiologue',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: HexColor('#747D8C'),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Divider(height: 1, color: Colors.grey.shade200),

                          // Informations personnelles
                          _buildOptionItem(
                            iconAsset: 'assets/icons/ic_infi.png',
                            title: 'Informations personnelles',
                            trailing: const Icon(Icons.chevron_right,
                                color: Colors.grey, size: 28),
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
                          Divider(height: 1, color: Colors.grey.shade200),

                          // Affiliations
                          _buildOptionItem(
                            iconAsset: 'assets/icons/ic_infi.png',
                            title: 'Affiliations',
                            trailing: const Icon(Icons.chevron_right,
                                color: Colors.grey, size: 28),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const DisponibilitePage(),
                                ),
                              );
                            },
                          ),
                          Divider(height: 1, color: Colors.grey.shade200),

                          // Notifications
                          _buildOptionItem(
                            iconAsset: 'assets/icons/notif.png',
                            title: 'Notifications',
                            trailing: Switch(
                              value: notificationsEnabled,
                              activeColor: HexColor('#2C7BE5'),
                              onChanged: (v) =>
                                  setState(() => notificationsEnabled = v),
                            ),
                          ),
                          Divider(height: 1, color: Colors.grey.shade200),

                          // Déconnexion
                          InkWell(
                            onTap: () => _showLogoutConfirm(context),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 14),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 18,
                                    backgroundColor: HexColor('#FEF3F2'),
                                    child: Icon(
                                      Icons.logout,
                                      size: 18,
                                      color: HexColor('#FF3B30'),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    'Se déconnecter',
                                    style: TextStyle(
                                      color: HexColor('#FF3B30'),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionItem({
    required String iconAsset,
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 14),
        child: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: HexColor('#EEF6FF'),
              child: Image.asset(
                iconAsset,
                width: 18,
                height: 18,
                errorBuilder: (_, __, ___) =>
                    Icon(Icons.info_outline, color: HexColor('#305579')),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  color: Color(0xFF1F2937),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text('Se déconnecter'),
        content: const Text('Voulez-vous vraiment vous déconnecter ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: HexColor('#305579'),
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
