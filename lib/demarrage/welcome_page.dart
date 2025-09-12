import 'package:flutter/material.dart';
import '../patient/utils/HexColor.dart';
import 'creercompte.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#EFF6FF'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              // Espace du haut
              const Spacer(flex: 4),
              
              // Logo
              Image.asset(
                'assets/images/logo.png', // Remplacez par le chemin de votre logo
                width: 96,
                height: 116,
                fit: BoxFit.contain,
              ),
              
              const SizedBox(height: 40),
              
              // Titre principal
               Text(
                "C'est parti !",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: HexColor('#101623'),
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 24),
              
              // Description
              Text(
                "Connectez-vous pour profiter des fonctionnalités que nous avons fournies et rester en bonne santé !",
                style: TextStyle(
                  fontSize: 16,
                  color: HexColor('#717784'),
                  height: 1.5,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              
              const Spacer(flex: 2),
              
              // Bouton Se connecter
               Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  color: HexColor('#285D90'),
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(
                    color: HexColor('#285D90'),
                    width: 2,
                  ),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    // Navigation vers la page d'inscription
                    // Navigator.push(context, MaterialPageRoute(builder: (_) => RegisterPage()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: HexColor('#285D90'),
                    shadowColor: HexColor( '#285D90'),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: Text(
                    'Se connecter',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: HexColor('#FFFFFF'),
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Bouton Créer un compte
              Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(
                    color: HexColor('#285D90'),
                    width: 2,
                  ),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    // Navigation vers la page d'inscription
                    Navigator.push(context, MaterialPageRoute(builder: (_) => CreateAccountPage()));
                    // Navigator.push(context, MaterialPageRoute(builder: (_) => RegisterPage()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: Text(
                    'Créer un compte',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: HexColor('#285D90'),
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 200),
            ],
          ),
        ),
      ),
    );
  }
}