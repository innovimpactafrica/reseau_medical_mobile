import 'package:flutter/material.dart';
import '../../utils/HexColor.dart';
import 'addcr.dart';

class PatientDetailPage extends StatefulWidget {
  const PatientDetailPage({super.key});

  @override
  State<PatientDetailPage> createState() => _PatientDetailPageState();
}

class _PatientDetailPageState extends State<PatientDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _docTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  // =================== ONGLET INFO ===================
  Widget _buildInfoTab() {
    return Container(
      color: HexColor("#F5F7FA"),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildInfoSection("Informations personnelles", [
              _buildInfoRow("Date de naissance", "10/10/1960"),
              _buildInfoRow("Sexe", "Masculin"),
              _buildInfoRow("Adresse", "Sacré Cœur"),
              _buildInfoRow("Maladie", "Grossesse"),
            ]),
            const SizedBox(height: 12),
            _buildInfoSection("Informations administratives", [
              _buildInfoRow("Numéro dossier", "ID: 123456"),
              _buildInfoRow("Couverture sociale", "Lorem"),
            ]),
            const SizedBox(height: 12),
            _buildInfoSection("Informations médicales", [
              _buildInfoRow("Antécédent médical", "-"),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(String title, List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 14,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
              flex: 3,
              child: Text(label,
                  style: const TextStyle(color: Colors.black87, fontSize: 14))),
          Expanded(
              flex: 2,
              child: Text(value,
                  style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 14))),
        ],
      ),
    );
  }

  // =================== ONGLET HISTORIQUES ===================
  Widget _buildHistoriquesTab() {
    return Container(
      color: HexColor("#F5F7FA"),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            // ===== Antécédents médicaux =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.history, color: Colors.blue, size: 20),
                      const SizedBox(width: 8),
                      const Text("Antécédents médicaux",
                          style: TextStyle(
                              fontSize: 16, 
                              fontWeight: FontWeight.w600, 
                              color: Colors.blue)),
                    ],
                  ),
                  const Text("Modifier",
                      style: TextStyle(
                          fontSize: 14, 
                          color: Colors.blue)),
                ],
              ),
            ),
            const SizedBox(height: 12),
            
            _buildMedicalHistoryCard("Octobre 2022", "Diagnostic d'hypertension", "Tension artérielle 150/95 mmHg"),
            _buildMedicalHistoryCard("Mars 2021", "Appendicectomie", "Intervention sans complications"),
            _buildMedicalHistoryCard("Janvier 2020", "Fracture du poignet droit", "Suite à une chute, plâtre pendant 6 semaines"),

            const SizedBox(height: 24),

            // ===== Antécédents familiaux =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.person, color: Colors.blue, size: 20),
                      const SizedBox(width: 8),
                      const Text("Antécédents familiaux",
                          style: TextStyle(
                              fontSize: 16, 
                              fontWeight: FontWeight.w600, 
                              color: Colors.blue)),
                    ],
                  ),
                  const Text("Modifier",
                      style: TextStyle(
                          fontSize: 14, 
                          color: Colors.blue)),
                ],
              ),
            ),
            const SizedBox(height: 12),
            
            _buildFamilyHistoryCard("Père", "Hypertension artérielle, Diabète type 2", "65 ans"),
            _buildFamilyHistoryCard("Mère", "Cancer du sein (rémission)", "62 ans"),
            _buildFamilyHistoryCard("Frère", "Asthme", "42 ans"),

            const SizedBox(height: 24),

            // ===== Historique des consultations =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.note_alt, color: Colors.blue, size: 20),
                      const SizedBox(width: 8),
                      const Text("Historique des consultations",
                          style: TextStyle(
                              fontSize: 16, 
                              fontWeight: FontWeight.w600, 
                              color: Colors.blue)),
                    ],
                  ),
                  const Text("Ajouter",
                      style: TextStyle(
                          fontSize: 14, 
                          color: Colors.blue)),
                ],
              ),
            ),
            const SizedBox(height: 12),
            
            _buildConsultationCard("15 juin 2025", "Dr. Lamine Diop", "Patiente se présente pour son suivi trimestriel d'hypertension. Tension artérielle sous contrôle avec le traitement actuel. Pas d'effets secondaires signalés. Maintien du traitement actuel."),
            _buildConsultationCard("15 juin 2025", "Dr. Lamine Diop", "Patiente se présente pour son suivi trimestriel d'hypertension. Tension artérielle sous contrôle avec le traitement actuel. Pas d'effets secondaires signalés. Maintien du traitement actuel."),

            const SizedBox(height: 24),

            // Boutons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return CompteRenduModal(); // <- la classe de la fenêtre modale
      },
    );
                      },
                      icon: const Icon(Icons.edit, color: Colors.white, size: 20),
                      label: const Text("Créer un compte rendu", 
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4A6FA5),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.list, color: Colors.red, size: 20),
                      label: const Text("Listez les comptes rendus",
                        style: TextStyle(color: Colors.red, fontSize: 16)),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: const BorderSide(color: Colors.red),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildMedicalHistoryCard(String date, String title, String description) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(date,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 14)),
              Text(title,
                  style: const TextStyle(
                      fontSize: 14, 
                      color: Colors.blue, 
                      decoration: TextDecoration.underline)),
            ],
          ),
          const SizedBox(height: 4),
          Text(description, 
              style: const TextStyle(color: Colors.black54, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildFamilyHistoryCard(String relation, String details, String age) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(relation,
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                const SizedBox(height: 4),
                Text(details,
                    style: const TextStyle(fontSize: 13, color: Colors.black54)),
              ],
            ),
          ),
          Text(age,
              style: const TextStyle(fontSize: 13, color: Colors.black54)),
        ],
      ),
    );
  }

  Widget _buildConsultationCard(String date, String doctor, String description) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.calendar_today, color: Colors.blue, size: 16),
                  const SizedBox(width: 4),
                  Text(date,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 14, color: Colors.blue)),
                ],
              ),
              Text(doctor,
                  style: const TextStyle(fontSize: 13, color: Colors.black54)),
            ],
          ),
          const SizedBox(height: 8),
          Text(description,
              style: const TextStyle(fontSize: 13, color: Colors.black54, height: 1.3)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.edit, size: 16, color: Colors.grey.shade500),
              const SizedBox(width: 12),
              Icon(Icons.print, size: 16, color: Colors.grey.shade500),
              const SizedBox(width: 12),
              Icon(Icons.share, size: 16, color: Colors.grey.shade500),
            ],
          ),
        ],
      ),
    );
  }

  // =================== ONGLET DOCUMENTS ===================
  Widget _buildDocumentsTab() {
    return Container(
      color: HexColor("#F5F7FA"),
      child: Column(
        children: [
          // Titre section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: const Text("Documents médicaux",
                style: TextStyle(
                    fontSize: 18, 
                    fontWeight: FontWeight.w600, 
                    color: Colors.blue)),
          ),
          
          // Onglets Documents
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _buildDocumentTab("Tous", 0),
                _buildDocumentTab("Examens", 1),
                _buildDocumentTab("Résultats", 2),
                _buildDocumentTab("Notes", 3),
              ],
            ),
          ),
          
          // Liste documents
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        _buildDocumentCard("Ordonnance", "January 15, 2023"),
                        _buildDocumentCard("Compte rendu", "January 15, 2023"),
                        _buildDocumentCard("Initial Consultation", "January 15, 2023"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.edit, color: Colors.white, size: 20),
                      label: const Text("Prescrire une ordonnance",
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4A6FA5),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.share, color: Colors.red, size: 20),
                      label: const Text("Partager la fiche avec un médecin",
                          style: TextStyle(color: Colors.red, fontSize: 16)),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: const BorderSide(color: Colors.red),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentTab(String text, int index) {
    bool isSelected = _docTabIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _docTabIndex = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? Colors.red : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Center(
            child: Text(text,
                style: TextStyle(
                    color: isSelected ? Colors.red : Colors.black54,
                    fontWeight: FontWeight.w500,
                    fontSize: 14)),
          ),
        ),
      ),
    );
  }

  Widget _buildDocumentCard(String title, String date) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.insert_drive_file, color: Colors.blue, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(date, style: const TextStyle(color: Colors.black54, fontSize: 13)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
        ],
      ),
    );
  }

  // =================== ONGLET RDV ===================
  Widget _buildRdvTab() {
    return Container(
      color: HexColor("#F5F7FA"),
      child: Column(
        children: [
          // Titre section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: const Text("Rendez-vous",
                style: TextStyle(
                    fontSize: 18, 
                    fontWeight: FontWeight.w600, 
                    color: Colors.blue)),
          ),
          
          // Liste RDV
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        _buildAppointmentCard("Consultation", "Sam. 13 septembre 2025, 10:00-12:00"),
                        _buildAppointmentCard("Suivi patient", "Lun. 15 septembre 2025, 14:00-15:00"),
                        _buildAppointmentCard("Consultation", "Lun. 15 septembre 2025, 14:00-15:00"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.add, color: Colors.white, size: 20),
                      label: const Text("Ajouter un rendez-vous",
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4A6FA5),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentCard(String title, String dateTime) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.calendar_today, color: Colors.blue, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(dateTime, style: const TextStyle(color: Colors.black54, fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#F5F7FA"),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4A6FA5),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Détails Patient",
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onSelected: (String value) {
              // Gérer les actions du menu
              switch (value) {
                case 'ordonnance':
                  // Action créer ordonnance
                  break;
                case 'note':
                  // Action ajouter note
                  break;
                case 'document':
                  // Action ajouter document
                  break;
                case 'rdv':
                  // Action programmer RDV
                  break;
                case 'message':
                  // Action envoyer message
                  break;
                case 'compte_rendu':
                  // Action ajouter compte rendu
                  break;
                case 'partager':
                  // Action partager le dossier
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              
               PopupMenuItem<String>(
                value: 'ordonnance',
                child: Row(
                  children: [
                    Image.asset('assets/icons/filetext.png'),
                    SizedBox(width: 12),
                    Text('Créer une ordonnance', style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
               PopupMenuItem<String>(
                value: 'note',
                child: Row(
                  children: [
                    Image.asset('assets/icons/proicons.png'),
                    SizedBox(width: 12),
                    Text('Ajouter une note', style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
               PopupMenuItem<String>(
                value: 'document',
                child: Row(
                  children: [
                    Image.asset('assets/icons/filedoc.png'),
                    SizedBox(width: 12),
                    Text('Ajouter un document', style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
               PopupMenuItem<String>(
                value: 'rdv',
                child: Row(
                  children: [
                    Image.asset('assets/icons/programme.png'),
                    SizedBox(width: 12),
                    Text('Programmer un RDV', style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
               PopupMenuItem<String>(
                value: 'message',
                child: Row(
                  children: [
                    Image.asset('assets/icons/mess.png'),
                    SizedBox(width: 12),
                    Text('Envoyer un message', style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
               PopupMenuItem<String>(
                value: 'compte_rendu',
                child: Row(
                  children: [
                    Image.asset('assets/icons/filedoc.png'),
                    SizedBox(width: 12),
                    Text('Ajouter un compte rendu', style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
               PopupMenuItem<String>(
                value: 'partager',
                child: Row(
                  children: [
                    Image.asset('assets/icons/share.png'),
                    SizedBox(width: 12),
                    Text('Partager le dossier', style: TextStyle(fontSize: 14, color: Colors.red)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // En-tête patient
          Container(
            width: double.infinity,
            padding:  EdgeInsets.symmetric(vertical: 20),
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.person, size: 36, color: Colors.white),
                ),
                const SizedBox(height: 8),
                const Text("Amadou Ndiaye",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                const Text("ID: 123456",
                    style: TextStyle(color: Colors.black54, fontSize: 13)),
              ],
            ),
          ),
          
          // Onglets principaux
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              indicatorColor: Colors.red,
              indicatorWeight: 2,
              labelColor: Colors.red,
              unselectedLabelColor: Colors.black54,
              labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              unselectedLabelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
              tabs: const [
                Tab(text: "Info"),
                Tab(text: "Historiques"),
                Tab(text: "Documents"),
                Tab(text: "RDV"),
              ],
            ),
          ),
          
          // Contenu
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildInfoTab(),
                _buildHistoriquesTab(),
                _buildDocumentsTab(),
                _buildRdvTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}