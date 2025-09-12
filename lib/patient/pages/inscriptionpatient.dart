import 'package:flutter/material.dart';
import 'package:rmelapp/patient/pages/verification.dart';
import '../utils/HexColor.dart';

class Inscription extends StatelessWidget {
  const Inscription({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // ✅ fond blanc
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: HexColor('#1E3A8A')),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  "Inscription Patient",
                  style: TextStyle(
                    fontSize: 24,
                    color: HexColor('#1E3A8A'),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Créez votre compte personnel pour prendre rendez-vous",
                  style: TextStyle(
                    fontSize: 16,
                    color: HexColor('#6C7278'),
                  ),
                ),
                const SizedBox(height: 30),

                // Champ Prénom
                RichText(
                  text: TextSpan(
                    text: "Prénom",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: HexColor('#333333'),
                      fontSize: 16,
                    ),
                    children: const [
                      TextSpan(
                        text: " *",
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                TextField(
                  decoration: InputDecoration(
                    hintText: "ex. Fatou",
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Image.asset(
                        "assets/icons/user.png",
                        width: 22,
                        height: 22,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: HexColor("#CBD5E1")),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  ),
                ),
                const SizedBox(height: 20),

                // Champ Nom
                RichText(
                  text: TextSpan(
                    text: "Nom",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: HexColor('#333333'),
                      fontSize: 16,
                    ),
                    children: const [
                      TextSpan(
                        text: " *",
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                TextField(
                  decoration: InputDecoration(
                    hintText: "ex. Ndiaye",
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Image.asset(
                        "assets/icons/user.png",
                        width: 22,
                        height: 22,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: HexColor("#9C9AA5")),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  ),
                ),
                const SizedBox(height: 20),

                // Champ Téléphone
                RichText(
                  text: TextSpan(
                    text: "Numéro de téléphone",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: HexColor('#333333'),
                      fontSize: 14,
                    ),
                    children: const [
                      TextSpan(
                        text: " *",
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                TextField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: "ex. 77 000 00 00",
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Image.asset(
                        "assets/icons/phone.png",
                        width: 22,
                        height: 22,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: HexColor("#CBD5E1")),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  ),
                ),
                const SizedBox(height: 20),

                // Champ Email
                Text("Email",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: HexColor('#333333'))),
                const SizedBox(height: 6),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "ex. prenom.nom@gmail.com",
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Image.asset(
                        "assets/icons/email.png",
                        width: 22,
                        height: 22,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: HexColor("#CBD5E1")),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  ),
                ),
                const SizedBox(height: 20),

                // Champ Adresse
                Text("Adresse",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: HexColor('#333333'))),
                const SizedBox(height: 6),
                TextField(
                  decoration: InputDecoration(
                    hintText: "ex. Dakar",
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Image.asset(
                        "assets/icons/location.png",
                        width: 22,
                        height: 22,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: HexColor("#CBD5E1")),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  ),
                ),
                const SizedBox(height: 30),

                // Bouton Continuer
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: HexColor('#285D90'),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const Verification()));
                      // Action inscription
                    },
                    child: const Text("S'inscrire",
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ),

                const Spacer(),

                // Déjà inscrit ? Se connecter
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Déjà inscrit ? "),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "/connexion");
                        },
                        child: Text(
                          "Se connecter",
                          style: TextStyle(
                            color: HexColor('#B53C3A'),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
