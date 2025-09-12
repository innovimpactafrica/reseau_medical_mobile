import 'package:flutter/material.dart';
import 'package:rmelapp/medecin/pages/document_justificatifs.dart';

import '../utils/HexColor.dart';

// Déclaration d'une liste de spécialités (tu peux adapter)
final List<String> specialites = [
  "Cardiologie",
  "Dermatologie",
  "Pédiatrie",
  "Gynécologie",
  "Orthopédie",
];

String? selectedSpecialite; // variable pour stocker la sélection


class Inscriptiondoctor extends StatelessWidget {
  const Inscriptiondoctor({super.key});


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
                  "Inscription Medecin",
                  style: TextStyle(
                    fontSize: 24,
                    color: HexColor('#1E3A8A'),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Créez votre compte professionnel  medical",
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

                RichText(
  text: TextSpan(
    text: "Spécialité médicale",
    style: TextStyle(
      fontWeight: FontWeight.w600,
      color: HexColor('#333333'),
      fontSize: 16,
    ),
    children: const [
      
    ],
  ),
),

const SizedBox(height: 6),
DropdownButtonFormField<String>(
  value: selectedSpecialite,
  decoration: InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: HexColor("#CBD5E1")),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
  ),
  hint: const Text("Sélectionner"),
  items: specialites.map((specialite) {
    return DropdownMenuItem<String>(
      value: specialite,
      child: Text(specialite),
    );
  }).toList(),
  onChanged: (value) {
    selectedSpecialite = value;
  },
),
const SizedBox(height: 20),


                  // Champ Email
                Text("Adresse e-mail professionnelle",
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
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const DocumentsJustificatifsPage()));
                      // Action inscription
                    },
                    child: const Text("Continuer",
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ),

                const SizedBox(height: 50,),

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
