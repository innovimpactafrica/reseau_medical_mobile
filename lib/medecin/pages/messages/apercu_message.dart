import 'package:flutter/material.dart';
import '../../utils/HexColor.dart';
import '../ordonnance/detail_patient.dart';

class ChatPage extends StatelessWidget {
  final String patientName;
  final String initials;

  const ChatPage({
    super.key,
    required this.patientName,
    required this.initials,
  });

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
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  patientName, // ✅ Nom dynamique
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
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
          IconButton(
            icon: Image.asset('assets/icons/filepa.png'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PatientDetailPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),

          // ✅ Badge date centré
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

          // ✅ Messages
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                _buildSenderMessage(
                  text: "Bonjour $patientName, comment vous sentez-vous ?",
                  time: "10:30",
                ),
                _buildReceiverMessage(
                  initials: initials,
                  text:
                      "Bonjour Docteur, je me sens beaucoup mieux. Les médicaments semblent faire effet.",
                  time: "10:35",
                ),
                _buildSenderMessage(
                  text:
                      "Excellent ! Continuez à prendre vos médicaments comme prescrit. Avez-vous des effets secondaires ?",
                  time: "10:35",
                ),
              ],
            ),
          ),

          // ✅ Champ de saisie
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
                  icon: Icon(Icons.attach_file, color: HexColor("#7C8BA0")),
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

  /// ✅ Message envoyé
  Widget _buildSenderMessage({
    required String text,
    required String time,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
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
                  Text(text,
                      style: const TextStyle(color: Colors.white, fontSize: 15)),
                  const SizedBox(height: 4),
                  Text(time,
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 11)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ✅ Message reçu
  Widget _buildReceiverMessage({
    required String initials,
    required String text,
    required String time,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: HexColor("#D1D5DB"),
            child: Text(
              initials,
              style: TextStyle(color: HexColor("#374151"), fontSize: 12),
            ),
          ),
          const SizedBox(width: 8),
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
                  Text(text,
                      style:
                          const TextStyle(color: Colors.black87, fontSize: 15)),
                  const SizedBox(height: 4),
                  Text(time,
                      style:
                          TextStyle(color: Colors.grey.shade600, fontSize: 11)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
