import 'package:flutter/material.dart';
import '../patient/utils/HexColor.dart';

// Importez vos pages d'inscription

import '../medecin/pages/inscriptiondoctor.dart';
import '../patient/pages/inscriptionpatient.dart';

class CreateAccountPage extends StatelessWidget {
  const CreateAccountPage({super.key});

  void _goToSignUp(BuildContext context, String profile) {
    Widget page;
    switch (profile) {
      case 'doctor':
        page = const Inscriptiondoctor();
        break;
     
      case 'patient':
        page = const Inscription();
        break;
      default:
        page = const Inscription();
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#EFF6FF'),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: HexColor('#1E3A8A'),
            size: 28,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              "Créer un compte",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: HexColor('#1E3A8A'),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Sélectionnez votre profil pour personnaliser votre expérience",
              style: TextStyle(
                fontSize: 16,
                color: HexColor('#1E40AF'),
                height: 1.4,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 40),

            /// Cartes de profils
            Expanded(
              child: Column(
                children: [
                  ProfileCard(
                    iconPath: 'assets/icons/medecin.png',
                    title: 'Médecin',
                    subtitle: 'Gérer vos consultations et suivez vos patients...',
                    onTap: () => _goToSignUp(context, 'doctor'),
                  ),
                  const SizedBox(height: 20),
                  ProfileCard(
                    iconPath: 'assets/icons/centre.png',
                    title: 'Centre de santé',
                    subtitle: 'Gérer votre établissement et votre personnel médical.',
                    onTap: () => _goToSignUp(context, 'health_center'),
                  ),
                  const SizedBox(height: 20),
                  ProfileCard(
                    iconPath: 'assets/icons/patient.png',
                    title: 'Patient',
                    subtitle: 'Prenez rendez-vous et accéder à votre dossier médical',
                    onTap: () => _goToSignUp(context, 'patient'),
                  ),
                  const Spacer(),

                  /// Texte de connexion
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Déjà inscrit ? ",
                        style: TextStyle(
                          fontSize: 16,
                          color: HexColor('#6C7278'),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigator vers LoginPage
                        },
                        child: Text(
                          "Se connecter",
                          style: TextStyle(
                            fontSize: 16,
                            color: HexColor('#B53C3A'),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final String iconPath;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const ProfileCard({
    super.key,
    required this.iconPath,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: HexColor('#E5E7EB'), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: HexColor('#DBEAFE'),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Image.asset(
                  iconPath,
                  width: 35,
                  height: 35,
                  
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: HexColor('#1E3A8A'),
                      )),
                  const SizedBox(height: 4),
                  Text(subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: HexColor('#1E3A8A'),
                        height: 1.3,
                        fontWeight: FontWeight.w500,
                      )),
                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
