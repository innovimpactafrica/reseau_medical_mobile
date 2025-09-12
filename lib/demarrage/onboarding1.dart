import 'package:flutter/material.dart';
import '../patient/utils/HexColor.dart';
import 'welcome_page.dart';

class Onboarding1 extends StatefulWidget {
  const Onboarding1({super.key});

  @override
  State<Onboarding1> createState() => _Onboarding1State();
}

class _Onboarding1State extends State<Onboarding1> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "image": "assets/images/femme.png",
      "title": "Bienvenue sur RÉSEAU MÉDICAL EN LIGNE",
      "subtitle":
          "Votre plateforme de santé connectée pour simplifier la gestion des consultations médicales au Sénégal."
    },
    {
      "image": "assets/images/homme1.png",
      "title": "Prenez rendez-vous facilement",
      "subtitle":
          "Trouvez un médecin disponible et réservez votre consultation en quelques clics. Gérez votre agenda médical en toute simplicité."
    },
    {
      "image": "assets/images/coup1.png",
      "title": "Accédez à vos dossiers médicaux",
      "subtitle":
          "Consultez votre historique médical, vos ordonnances et vos résultats d'analyses à tout moment, en toute sécurité et confidentialité."
    },
    {
      "image": "assets/images/assistant 1.png",
      "title": "Communiquez avec vos médecins",
      "subtitle":
          "Échangez en toute sécurité avec vos professionnels de santé via notre messagerie intégrée. Posez vos questions et recevez des réponses rapidement."
    },
    {
      "image": "assets/images/homme1.png",
      "title": "Prêt à commencer ?",
      "subtitle":
          "Créez votre compte en quelques minutes et accédez à tous nos services. Une expérience médicale simplifiée vous attend."
    },
  ];

  void _goToLogin(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const WelcomePage()));
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: HexColor('#EFF6FF'),
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: onboardingData.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              final data = onboardingData[index];
              return SingleChildScrollView(
                child: SizedBox(
                  height: screenHeight,
                  child: Column(
                    children: [
                      const SizedBox(height: 50),

                      /// Bouton Passer
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: GestureDetector(
                            onTap: () => _goToLogin(context),
                            child: Text(
                              "Passer",
                              style: TextStyle(
                                color: HexColor("#A1A8B0"),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// Zone image avec conteneur superposé
                      Expanded(
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            /// Image principale
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              bottom: 180,
                              child: Image.asset(
                                data["image"]!,
                                width: double.infinity,
                                fit: BoxFit.contain,
                              ),
                            ),

                             /// Superposition grise sous le box
      Positioned(
        bottom: 100 - 30, // juste sous le box bleu
        left: 75,
        right: 75,
        child: Container(
          height: 20,
          decoration: BoxDecoration(
            color: HexColor("#D2E2FC"),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),


                            /// Ombre bleue douce sous le box
                            Positioned(
                              bottom: 100 - 15, // juste sous le box
                              left: 50,
                              right: 50,
                              child: Container(
                                height: 20,
                                decoration: BoxDecoration(
                                  color: HexColor("#72A2F6"),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          HexColor("#72A2F6"),
                                      blurRadius: 20,
                                      offset: const Offset(0, 8),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            /// Box bleu superposé
                            Positioned(
                              bottom: 100,
                              left: 20,
                              right: 20,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 24, horizontal: 28),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      HexColor("#4F8EF7"),
                                      HexColor("#1E3A8A"),
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      data["title"]!,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        height: 1.2,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      data["subtitle"]!,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        height: 1.4,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              );
            },
          ),

          /// Indicateurs + bouton flèche fixes en bas
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Indicateurs
                Row(
                  children: List.generate(
                    onboardingData.length,
                    (i) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: _currentPage == i ? 20 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _currentPage == i
                            ? HexColor("#4F8EF7")
                            : HexColor("#C1C7CD"),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),

                /// Bouton flèche
                GestureDetector(
                  onTap: () {
                    if (_currentPage == onboardingData.length - 1) {
                      _goToLogin(context);
                    } else {
                      _controller.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: HexColor("#4F8EF7"),
                      boxShadow: [
                        BoxShadow(
                          color: HexColor("#4F8EF7").withOpacity(0.4),
                          blurRadius: 12,
                          spreadRadius: 0,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
