import 'package:flutter/material.dart';
import '../utils/HexColor.dart';
import 'dashboard.dart';
class Connexion extends StatefulWidget {
  const Connexion({super.key});

  @override
  State<Connexion> createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
         
         

          // Contenu principal
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Se connecter",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: HexColor("#1E3A8A"),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Accédez à votre tableau de bord",
                  style: TextStyle(
                    fontSize: 14,
                    color: HexColor("#6C7278"),
                  ),
                ),
                const SizedBox(height: 30),

                // Champ Email
                Text(
                  "Identifiant",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: HexColor("#333333"),
                  ),
                ),
                const SizedBox(height: 6),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "exemple@gmail.com",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: HexColor("#CBD5E1")),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: HexColor("#CBD5E1")),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: HexColor("#D4B036")),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 14),
                  ),
                ),
                const SizedBox(height: 20),

                // Champ Mot de passe
                Text(
                  "Mot de passe",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: HexColor("#333333"),
                  ),
                ),
                const SizedBox(height: 6),
                TextField(
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    hintText: "********",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: HexColor("#CBD5E1")),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: HexColor("#CBD5E1")),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: HexColor("#D4B036")),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 14),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: HexColor("#ACB5BB"),
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Bouton Connexion
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: HexColor("#285D90"),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const DashboardPage()),
      );
                    },
                    child: const Text(
                      "Se connecter",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 25),

                // Séparateur "Ou"
                Row(
                  children: [
                    Expanded(child: Divider(color: HexColor('#EDF1F3'))),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text("Ou",
                          style: TextStyle(color: HexColor("#6C7278"))),
                    ),
                    Expanded(child: Divider(color: HexColor('#EDF1F3'))),
                  ],
                ),
                const SizedBox(height: 20),

                // Boutons Google & Apple
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          foregroundColor: HexColor("#1A1C1E"),
                        ),
                        onPressed: () {},
                        icon: Image.asset(
                          "assets/icons/google.png",
                          height: 18,
                        ),
                        label: const Text("Google"),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          foregroundColor: HexColor("#1A1C1E"),
                        ),
                        onPressed: () {},
                        icon: Image.asset(
                          "assets/icons/apple.png",
                          height: 18,
                        ),
                        label: const Text("Apple"),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 200),

                // Lien inscription
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Pas de compte ",
                          style: TextStyle(color: HexColor("#6C7278"))),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "/inscription");
                        },
                        child: Text(
                          "S’inscrire",
                          style: TextStyle(
                            color: HexColor("#B53C3A"),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
