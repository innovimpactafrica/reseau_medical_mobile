import 'package:flutter/material.dart';
import 'package:rmelapp/medecin/utils/HexColor.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: NouveauPatientPage(),
  ));
}

class NouveauPatientPage extends StatelessWidget {
  const NouveauPatientPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fond dégradé bleu
      body: Container(
        decoration:  BoxDecoration(
          gradient: LinearGradient(
            colors: [
              HexColor('#305579'),
              HexColor('#1C3752'), // Bleu moyen
              HexColor('FFFFFF'), // Bleu clair
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Barre de titre centrée
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Bouton retour à gauche
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.arrow_back, color: Colors.white),
                      ),
                    ),
                    // Titre centré
                    const Text(
                      "Nouveau Patient",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Formulaire principal
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildInputField("Prénom", "Entrez le prénom", "assets/icons/user.png", true),
                        buildInputField("Nom", "Entrez le nom", "assets/icons/user.png", true),
                        buildInputField("Date de naissance", "jj/mm/aaaa", "assets/icons/rdv.png", true, isDate: true),
                        buildDropdownField("Sexe", true),
                        buildInputField("Adresse", "Entrez l’adresse", "assets/icons/location.png", false),
                        buildInputField("Numéro de téléphone", "Entrez le numéro", "assets/icons/phone.png", true, isPhone: true),
                        buildTextArea("Antécédents médicaux", "Entrez les antécédents…"),
                        buildTextArea("Allergies", "Entrez les allergies…"),

                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1C4A7E),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {},
                            child: const Text(
                              "Enregistrer",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 Champ de saisie standard
  Widget buildInputField(String label, String hint, String iconPath, bool required,
      {bool isDate = false, bool isPhone = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: label,
              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
              children: required
                  ? [const TextSpan(text: "  *", style: TextStyle(color: Colors.red))]
                  : [],
            ),
          ),
          const SizedBox(height: 6),
          TextField(
            keyboardType: isPhone ? TextInputType.phone : TextInputType.text,
            readOnly: isDate,
            onTap: isDate
                ? () {
                    // Tu pourras ajouter ici un sélecteur de date
                  }
                : null,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.grey),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFF1C4A7E)),
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset(iconPath, width: 18, height: 18, color: Colors.grey[600]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Champ de sélection (Dropdown)
  Widget buildDropdownField(String label, bool required) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: label,
              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
              children: required
                  ? [const TextSpan(text: "  *", style: TextStyle(color: Colors.red))]
                  : [],
            ),
          ),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
              ),
            ),
            hint: const Text("Sélectionner"),
            items: ["Masculin", "Féminin", "Autre"]
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }

  // 🔹 Zone de texte (multiligne)
  Widget buildTextArea(String label, String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          TextField(
            maxLines: 4,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.grey),
              contentPadding: const EdgeInsets.all(12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFF1C4A7E)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
