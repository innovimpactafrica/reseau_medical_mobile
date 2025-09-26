import 'package:flutter/material.dart';

class CompteRenduPage extends StatefulWidget {
  const CompteRenduPage({Key? key}) : super(key: key);

  @override
  State<CompteRenduPage> createState() => _CompteRenduPageState();
}

class _CompteRenduPageState extends State<CompteRenduPage> {
  int selectedTabIndex = 0;
  final List<String> tabs = ["Tous", "Texte", "Audio", "Vidéo"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4A6FA5),
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text(
          "Compte rendu",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Container blanc avec les onglets
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: tabs.asMap().entries.map((entry) {
                int index = entry.key;
                String tab = entry.value;
                bool isSelected = index == selectedTabIndex;
                
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => selectedTabIndex = index),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFFB85450) : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        tab,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isSelected ? Colors.white : const Color(0xFF666666),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          
          // Liste des comptes rendus
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Premier élément sélectionné avec bordure violette
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFF9C27B0),
                      width: 2,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Bordure en pointillés
                      Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: const Color(0xFF9C27B0),
                            width: 1,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: CustomPaint(
                          painter: DashedBorderPainter(),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.description, color: Color(0xFF666666), size: 20),
                                    const SizedBox(width: 8),
                                    const Text(
                                      "CR - 1222",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    const Spacer(),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFE3F2FD),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: const Text(
                                        "Texte",
                                        style: TextStyle(
                                          color: Color(0xFF2196F3),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  "Consultation",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  "12/05/2025 • txt",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      "Détails",
                                      style: TextStyle(
                                        color: Color(0xFF2196F3),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
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
                
                // Deuxième élément
                _buildCompteRenduItem(
                  "CR-1223",
                  "Annalyse",
                  "05/05/2023 • txt",
                  "Texte",
                  const Color(0xFF2196F3),
                  const Color(0xFFE3F2FD),
                  showNonModifiable: true,
                ),
                
                // Troisième élément
                _buildCompteRenduItem(
                  "CR-1224",
                  "Radio",
                  "15/05/2023 • mp4",
                  "Vidéo",
                  const Color(0xFFE91E63),
                  const Color(0xFFFCE4EC),
                ),
                
                // Quatrième élément
                _buildCompteRenduItem(
                  "CR-1225",
                  "Prise de sang",
                  "20/04/2025 • mp3",
                  "Audio",
                  const Color(0xFFFF9800),
                  const Color(0xFFFFF3E0),
                  showNonModifiable: true,
                ),
              ],
            ),
          ),
        ],
      ),
      
      // Bouton flottant
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF2196F3),
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }

  Widget _buildCompteRenduItem(
    String title,
    String subtitle,
    String date,
    String type,
    Color typeColor,
    Color typeBgColor,
    {bool showNonModifiable = false}
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.description, color: Color(0xFF666666), size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: typeBgColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  type,
                  style: TextStyle(
                    color: typeColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            date,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF666666),
            ),
          ),
          const SizedBox(height: 12),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (showNonModifiable)
                const Text(
                  "Non modifiable",
                  style: TextStyle(
                    color: Color(0xFFE91E63),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                )
              else
                const SizedBox.shrink(),
              
              TextButton(
                onPressed: () {},
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Détails",
                      style: TextStyle(
                        color: Color(0xFF2196F3),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Color(0xFF2196F3),
                      size: 18,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DashedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = const Color(0xFF9C27B0)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    const double dashWidth = 4;
    const double dashSpace = 4;
    
    // Top border
    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset(startX + dashWidth > size.width ? size.width : startX + dashWidth, 0),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
    
    // Right border
    double startY = 0;
    while (startY < size.height) {
      canvas.drawLine(
        Offset(size.width, startY),
        Offset(size.width, startY + dashWidth > size.height ? size.height : startY + dashWidth),
        paint,
      );
      startY += dashWidth + dashSpace;
    }
    
    // Bottom border
    startX = size.width;
    while (startX > 0) {
      canvas.drawLine(
        Offset(startX, size.height),
        Offset(startX - dashWidth < 0 ? 0 : startX - dashWidth, size.height),
        paint,
      );
      startX -= dashWidth + dashSpace;
    }
    
    // Left border
    startY = size.height;
    while (startY > 0) {
      canvas.drawLine(
        Offset(0, startY),
        Offset(0, startY - dashWidth < 0 ? 0 : startY - dashWidth),
        paint,
      );
      startY -= dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}