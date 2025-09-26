import 'package:flutter/material.dart';
import '../../utils/HexColor.dart';
import 'tabs/info-tab.dart';
import 'tabs/historique_tab.dart';
import 'tabs/document_tab.dart';
import 'tabs/rdv_tab.dart';

// Couleurs utilisées
final Color redActive = Color(0xFFD81B60);
final Color greyInactive = Color(0xFF9E9E9E);
final Color lightGreyBg = Color(0xFFF5F7FA);

class PatientDetailPage extends StatefulWidget {
  const PatientDetailPage({Key? key}) : super(key: key);

  @override
  State<PatientDetailPage> createState() => _PatientDetailPageState();
}

class _PatientDetailPageState extends State<PatientDetailPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentTabIndex =
        (_tabController.index >= 0 && _tabController.index < 4) ? _tabController.index : 0;

    return Scaffold(
      backgroundColor: lightGreyBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [HexColor('#305579'), HexColor('#1C3752')],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text(
          "Détails Patient",
          style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Photo + nom
          Container(
            color: HexColor('#F2F5FA'),
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: const [
                CircleAvatar(
                  radius: 34,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, size: 40, color: Colors.white),
                ),
                SizedBox(height: 10),
                Text("Amadou Ndiaye",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24)),
                SizedBox(height: 4),
                Text("ID: 123456",
                    style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w500)),
              ],
            ),
          ),

          // Onglets personnalisés
          Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(4, (index) {
                final titles = ["Info", "Historiques", "Documents", "RDV"];
                final isSelected = currentTabIndex == index;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => _tabController.animateTo(index),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            titles[index],
                            style: TextStyle(
                              color: isSelected ? redActive : greyInactive,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Container(
                          height: 3,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          color: isSelected ? redActive : Colors.transparent,
                        )
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),

          // Contenu des tabs
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children:  [
                InfoTab(),
                HistoriqueTab(),
                DocumentsTab(
  doctorName: "Dr. Amadou",
  specialty: "Cardiologue",
  clinic: "Clinique XYZ",
  initials: "AA",
),
                RdvTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
