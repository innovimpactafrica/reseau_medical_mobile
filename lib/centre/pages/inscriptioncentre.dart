import 'package:flutter/material.dart';
import '../../patient/utils/HexColor.dart';

class Inscriptioncentre extends StatelessWidget {
  const Inscriptioncentre({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // ✅ fond blanc
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon:  Icon(Icons.arrow_back, color: HexColor('#1E3A8A')),
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
                  "Inscriptioncentre Patient",
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
                    prefixIcon: const Icon(Icons.person_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: HexColor("#CBD5E1")),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
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
                    prefixIcon: const Icon(Icons.person_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: HexColor("#9C9AA5")),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
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
                    suffixIcon: Icon(Icons.phone_outlined, color: HexColor('#ACB5BB')),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: HexColor("#CBD5E1")),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
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
                    suffixIcon: Icon(Icons.email_outlined, color: HexColor('#ACB5BB')),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: HexColor("#CBD5E1")),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
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
                    prefixIcon: Icon(Icons.location_on_outlined, color: HexColor('#ACB5BB')),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: HexColor("#CBD5E1")),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
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
