import 'package:flutter/material.dart';
import '../../utils/HexColor.dart';
import 'apercu_message.dart'; // ✅ On importe ta page de discussion

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#F9FAFB'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ✅ Header bleu avec flèche retour
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(12, 60, 12, 20),
            color: HexColor("#305579"),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                const Expanded(
                  child: Text(
                    "Choisir un patient",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 48), // équilibre la flèche gauche
              ],
            ),
          ),

          // ✅ Contenu principal
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: medecins.map((med) {
                  return _buildMedecinCard(
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
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ✅ Widget Card médecin
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
            // ✅ Avatar avec initiales
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

            // ✅ Infos médecin
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

            // ✅ Heure du dernier message
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
