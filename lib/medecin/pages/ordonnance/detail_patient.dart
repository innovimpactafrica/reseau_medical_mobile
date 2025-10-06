import 'package:flutter/material.dart';
import '../../utils/HexColor.dart';
import 'tabs/info-tab.dart';
import 'tabs/historique_tab.dart';
import 'tabs/document_tab.dart';
import 'tabs/rdv_tab.dart';

// Couleurs utilisées
final Color redActive = const Color(0xFFD81B60);
final Color greyInactive = const Color(0xFF9E9E9E);
final Color lightGreyBg = const Color(0xFFF5F7FA);

class PatientDetailPage extends StatefulWidget {
  const PatientDetailPage({Key? key}) : super(key: key);

  @override
  State<PatientDetailPage> createState() => _PatientDetailPageState();
}

class _PatientDetailPageState extends State<PatientDetailPage>
    with SingleTickerProviderStateMixin {
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
        (_tabController.index >= 0 && _tabController.index < 4)
            ? _tabController.index
            : 0;

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
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
        ),
        actions: [
          PopupMenuButton<int>(
            color: Colors.white,
            icon: const Icon(Icons.more_vert, color: Colors.white),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: [
                    Image.asset("assets/icons/filetext.png",
                        width: 20, height: 20),
                    const SizedBox(width: 8),
                    const Text("Créer une ordonnance"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: Row(
                  children: [
                    Image.asset("assets/icons/proicons.png",
                        width: 20, height: 20),
                    const SizedBox(width: 8),
                    const Text("Ajouter une note"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 3,
                child: Row(
                  children: [
                    Image.asset("assets/icons/filedoc.png",
                        width: 20, height: 20),
                    const SizedBox(width: 8),
                    const Text("Ajouter un document"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 4,
                child: Row(
                  children: [
                    Image.asset("assets/icons/programme.png",
                        width: 20, height: 20),
                    const SizedBox(width: 8),
                    const Text("Programmer un RDV"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 5,
                child: Row(
                  children: [
                    Image.asset("assets/icons/mess.png",
                        width: 20, height: 20),
                    const SizedBox(width: 8),
                    const Text("Envoyer un message"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 6,
                child: Row(
                  children: [
                    Image.asset("assets/icons/filedoc.png",
                        width: 20, height: 20),
                    const SizedBox(width: 8),
                    const Text("Ajouter un compte rendu"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 7,
                child: Row(
                  children: [
                    Image.asset("assets/icons/share.png",
                        width: 20, height: 20, color: HexColor('#B53C3A')),
                    const SizedBox(width: 8),
                     Text(
                      "Partager le dossier",
                      style: TextStyle(color: HexColor('#B53C3A')),
                    ),
                  ],
                ),
              ),
            ],
            onSelected: (value) {
              switch (value) {
                case 1:
                  print("Créer une ordonnance");
                  break;
                case 2:
                  print("Ajouter une note");
                  break;
                case 3:
                  print("Ajouter un document");
                  break;
                case 4:
                  print("Programmer un RDV");
                  break;
                case 5:
                  print("Envoyer un message");
                  break;
                case 6:
                  print("Ajouter un compte rendu");
                  break;
                case 7:
                  print("Partager le dossier");
                  break;
              }
            },
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
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 24)),
                SizedBox(height: 4),
                Text("ID: 123456",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w500)),
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
                          margin:
                              const EdgeInsets.symmetric(horizontal: 20),
                          color: isSelected
                              ? redActive
                              : Colors.transparent,
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
              children: [
                InfoTab(),
                HistoriqueTab(),
                DocumentsTab(
  doctorName: "Dr. Amadou",
  specialty: "Cardiologue",
  clinic: "Clinique XYZ",
  initials: "AA",
  patientName: "Amadou Ndiaye",
  patientInitials: "AN",
  patientDetails: "ID: 123456, 30 ans, Male",
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
