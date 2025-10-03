import 'package:flutter/material.dart';

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
      backgroundColor: const Color(0xFF102A47),
      body: SafeArea(
        child: Column(
          children: [
            // Barre de titre
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Row(
                children: const [
                  Icon(Icons.arrow_back, color: Colors.white),
                  SizedBox(width: 16),
                  Text(
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

            // Formulaire
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
                        height: 50, // un peu plus petit
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
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInputField(String label, String hint, String iconPath, bool required,
      {bool isDate = false, bool isPhone = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14), // un peu plus petit
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
            decoration: InputDecoration(
              hintText: hint,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12), // réduit vertical
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.all(12),
                child: Image.asset(iconPath, width: 20, height: 20),
              ),
            ),
            readOnly: isDate,
            onTap: isDate
                ? () {
                    // Date picker
                  }
                : null,
          ),
        ],
      ),
    );
  }

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
              contentPadding: const EdgeInsets.all(12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
