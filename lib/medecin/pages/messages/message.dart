import 'package:flutter/material.dart';
import '../../utils/HexColor.dart';
import 'apercu_message.dart';

class Message extends StatefulWidget {
  const Message({super.key});

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  final List<Map<String, String>> medecins = [
    {
      "initials": "MS",
      "name": "Marie Sne",
      "heure": "16:45",
      "chat": "Bonjour Docteur, je me sens beaucoup mieux..."
    },
    {
      "initials": "AD",
      "name": "Amadou Diallo",
      "heure": "16:43",
      "chat": "Merci pour les conseils, Docteur. Je suivra..."
    },
    {
      "initials": "OS",
      "name": "Ousmane Sow",
      "heure": "Hier",
      "chat": "Est-ce que je dois continuer à utiliser mon..."
    },
  ];

  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    // Filtrer la liste selon la recherche
    List<Map<String, String>> filteredMedecins = medecins.where((med) {
      return med["name"]!.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: HexColor('#F9FAFB'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header avec titre aligné à gauche et flèche retour (tu peux réactiver la flèche si besoin)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(12, 60, 12, 20),
            color: HexColor("#305579"),
            child: const Text(
              "Messages",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),

          // Barre de recherche
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Rechercher un médecin',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),

          // Liste des cards réduite en largeur, centrée horizontalement
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                children: filteredMedecins.map((med) {
                  return Center(  // Centrer horizontalement la card
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,  // 90% de la largeur écran
                      child: _buildMedecinCard(
                        initials: med["initials"]!,
                        name: med["name"]!,
                        heure: med["heure"]!,
                        chat: med["chat"]!,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ChatPage(
                                patientName: med["name"]!,
                                initials: med["initials"]!,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedecinCard({
    required String initials,
    required String name,
    required String heure,
    required String chat,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: HexColor("#DBEAFE")),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: HexColor("#E9EFFD"),
              child: Text(
                initials,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: HexColor("#2563EB"),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    chat,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              heure,
              style: const TextStyle(
                color: Colors.black45,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
