import 'package:flutter/material.dart';
import '../../utils/HexColor.dart';
import '../verification.dart';

class InformationsPersonnellesPage extends StatefulWidget {
  const InformationsPersonnellesPage({super.key});

  @override
  State<InformationsPersonnellesPage> createState() => _InformationsPersonnellesPageState();
}

class _InformationsPersonnellesPageState extends State<InformationsPersonnellesPage> {
  final TextEditingController prenomController = TextEditingController(text: 'Marie');
  final TextEditingController nomController = TextEditingController(text: 'Ndiaye');
  final TextEditingController phoneController = TextEditingController(text: '77 123 45 67');
  final TextEditingController emailController = TextEditingController(text: 'mndiaye@gmail.com');
  final TextEditingController adresseController = TextEditingController(text: 'Dakar');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#F5F7FA'),
      body: Column(
        children: [
          // Header
          Container(
            height: 160,
            width: double.infinity,
            decoration: BoxDecoration(
              color: HexColor('#305579'),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            child: SafeArea(
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  const Text(
                    'Mon compte',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(width: 48), // espace équivalent à l'iconButton
                ],
              ),
            ),
          ),

          // Formulaire (scrollable)
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Transform.translate(
                  offset: const Offset(0, -60),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Avatar
                        Center(
                          child: ClipOval(
                            child: Container(
                              width: 80,
                              height: 80,
                              color: HexColor('#EEF2F6'),
                              child: Image.asset(
                                'assets/icons/avatar.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Texte en haut
                        Center(
                          child: Column(
                            children: [
                              Text(
                                'Marie Ndiaye',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: HexColor('#2F3542'),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Membre depuis juin 2023',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: HexColor('#747D8C'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Prénom
                        _buildTextField(
                          label: 'Prénom',
                          controller: prenomController,
                          icon: Icons.person_outline,
                        ),
                        const SizedBox(height: 12),

                        // Nom
                        _buildTextField(
                          label: 'Nom',
                          controller: nomController,
                          icon: Icons.person_outline,
                        ),
                        const SizedBox(height: 12),

                        // Téléphone
                        _buildTextField(
                          label: 'Numéro de téléphone',
                          controller: phoneController,
                          icon: Icons.phone_outlined,
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: 12),

                        // Email
                        _buildTextField(
                          label: 'Email',
                          controller: emailController,
                          icon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 12),

                        // Adresse
                        _buildTextField(
                          label: 'Adresse',
                          controller: adresseController,
                          icon: Icons.location_on_outlined,
                        ),
                        const SizedBox(height: 24),

                        // Bouton Mettre à jour
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (_) => const Verification()));
                              // TODO: ajouter logique de mise à jour
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: HexColor('#305579'),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Mettre à jour',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
            children: const [
              TextSpan(
                text: ' *',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            suffixIcon: Icon(icon, color: Colors.grey),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: HexColor('#305579')),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}
