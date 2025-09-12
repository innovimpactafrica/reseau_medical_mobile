import 'package:flutter/material.dart';
import 'package:rmelapp/medecin/pages/connexion_doctor.dart';
import '../utils/HexColor.dart';
import 'dashboard_doctor.dart'; // assure-toi d'importer ta page dashboard

class Motdepasse extends StatefulWidget {
  const Motdepasse({super.key});

  @override
  State<Motdepasse> createState() => _MotdepasseState();
}

class _MotdepasseState extends State<Motdepasse> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  void _showSuccessMessage() {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 200, // sort du bas
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: AnimatedOpacity(
            opacity: 1.0,
            duration: const Duration(milliseconds: 300),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: HexColor("#D4F0D6"),
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset('assets/icons/check.png'),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Succes !",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Votre mot de passe a été créé avec succès.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    // durée affichage puis redirection
    Future.delayed(const Duration(seconds: 2), () {
      overlayEntry.remove();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Connexiondoctor()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon:  Icon(Icons.arrow_back, color: HexColor("#1E3A8A")),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Création mot de passe",
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: HexColor("#1E3A8A")),
            ),
            const SizedBox(height: 10),
            Text(
              "Choisissez un nouveau mot de passe sécurisé pour votre compte.",
              style: TextStyle(fontSize: 14, color: HexColor("#6C7278")),
            ),
            const SizedBox(height: 20),
            Text("Nouveau mot de passe",
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: HexColor("#333333"))),
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
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: HexColor("#ACB5BB"),
                  ),
                  onPressed: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text("Confirmer mot de passe",
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: HexColor("#333333"))),
            const SizedBox(height: 6),
            TextField(
              obscureText: _obscureConfirmPassword,
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
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureConfirmPassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: HexColor("#ACB5BB"),
                  ),
                  onPressed: () =>
                      setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                ),
              ),
            ),
            const SizedBox(height: 10),

              Text(
              "Le mot de passe doit contenir au moins 8 caractères, une majuscule, une minuscule, un chiffre et un caractère spécial.",
              style: TextStyle(fontSize: 14, color: HexColor("#6C7278")),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: HexColor("#285D90"),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: _showSuccessMessage,
                child: const Text("Valider",
                    style: TextStyle(fontSize: 14, color: Colors.white)),
              ),
            ),
            const SizedBox(height: 250),
          ],
        ),
      ),
    );
  }
}
