import 'package:flutter/material.dart';
import '../utils/HexColor.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#F5F6FA"),
      appBar: AppBar(
        backgroundColor: HexColor("#305579"),
        elevation: 0,
        titleSpacing: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: HexColor('#D1D5DB'),
              child: Text(
                "LD",
                style: TextStyle(color: HexColor('#374151')),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Dr. Lamine Diop",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Cardiologie",
                  style: TextStyle(
                    color: HexColor('#F9FAFB'),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call, color: Colors.white),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.videocam, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),

          // Badge date centré
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: HexColor("#E5E7EB"),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "03 août 2025",
              style: TextStyle(color: HexColor('#374151'), fontSize: 13),
            ),
          ),

          const SizedBox(height: 12),

          // Messages
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                _buildSenderMessage(
                 
                  text:
                      "Dr. Diop, je ressens une douleur au niveau de la poitrine depuis ce matin.",
                  time: "10:25",
                ),
                _buildReceiverMessage(
                  initials: "M",
                  text:
                      "Bonjour M. Ndiaye. Pouvez-vous décrire cette douleur? Est-elle constante ou va-et-vient?",
                  time: "10:28",
                ),
                _buildSenderMessage(
                  
                  text:
                      "C'est une sensation de serrement qui va et vient, surtout quand je monte les escaliers.",
                  time: "10:34",
                ),
                _buildReceiverMessage(
                  initials: "M",
                  text:
                      "Avez-vous d'autres symptômes? Essoufflement, nausées?",
                  time: "10:38",
                ),
              ],
            ),
          ),

          // Champ de saisie
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Envoyer un message...",
                      hintStyle:
                          TextStyle(color: Colors.grey.shade500, fontSize: 15),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.attach_file,
                      color: HexColor("#7C8BA0")), // icône attach
                ),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: HexColor("#2E4A6F"),
                  child: const Icon(Icons.send, color: Colors.white, size: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Bulle message envoyé (à droite) avec avatar optionnel
  Widget _buildSenderMessage({
    String? initials,
    required String text,
    required String time,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Flexible(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: HexColor("#2E4A6F"),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(14),
                  topRight: Radius.circular(14),
                  bottomLeft: Radius.circular(14),
                  bottomRight: Radius.circular(6),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    text,
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    time,
                    style: const TextStyle(color: Colors.white70, fontSize: 11),
                  ),
                ],
              ),
            ),
          ),
          if (initials != null) ...[
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 16,
              backgroundColor: HexColor("#D1D5DB"),
              child: Text(
                initials,
                style: TextStyle(color: HexColor("#374151"), fontSize: 12),
              ),
            ),
          ],
        ],
      ),
    );
  }
/// Bulle message reçu (à gauche) avec avatar optionnel
  Widget _buildReceiverMessage({
    String? initials,
    required String text,
    required String time,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (initials != null) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor: HexColor("#D1D5DB"),
              child: Text(
                initials,
                style: TextStyle(color: HexColor("#374151"), fontSize: 12),
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(14),
                  topRight: Radius.circular(14),
                  bottomLeft: Radius.circular(6),
                  bottomRight: Radius.circular(14),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: const TextStyle(color: Colors.black87, fontSize: 15),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    time,
                    style:
                        TextStyle(color: Colors.grey.shade600, fontSize: 11),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
