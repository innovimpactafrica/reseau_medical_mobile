import 'package:flutter/material.dart';
import '../../utils/HexColor.dart';

// Couleurs utilisées
final Color blueDark = Color(0xFF2C3E5F);
final Color redActive = Color(0xFFD81B60);
final Color blueSectionTitle = Color(0xFF2196F3);
final Color greyInactive = Color(0xFF9E9E9E);
final Color lightGreyBg = Color(0xFFF5F7FA);
final Color blueLight = Color(0xFF64B5F6);

class PatientDetailPage extends StatefulWidget {
  const PatientDetailPage({Key? key}) : super(key: key);

  @override
  State<PatientDetailPage> createState() => _PatientDetailPageState();
}

class _PatientDetailPageState extends State<PatientDetailPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _docTabIndex = 0;

  final List<String> docTabs = ["Tous", "Examens", "Résultats", "Notes"];

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
    return Scaffold(
      backgroundColor: lightGreyBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [HexColor('#305579'), HexColor('#1C3752')],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            "Détails Patient",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {
              // Action à définir
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Section photo + nom + ID
          Container(
            color: HexColor('#F2F5FA'),
            padding: const EdgeInsets.symmetric(vertical: 20),
            width: double.infinity,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 34,
                  backgroundColor: Colors.grey[300],
                  child: Image.asset('assets/icons/avatar.png', color: Colors.grey[600]),
                ),
                const SizedBox(height: 10),
                Text(
                  "Amadou Ndiaye",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24, color: HexColor('#2F3542')),
                ),
                const SizedBox(height: 4),
                Text(
                  "ID: 123456",
                  style: TextStyle(color: HexColor('#747D8C'), fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),

          // Onglets personnalisés
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(4, (index) {
                final titles = ["Info", "Historiques", "Documents", "RDV"];
                final isSelected = _tabController.index == index;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => _tabController.animateTo(index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected ? redActive.withOpacity(0.1) : Colors.transparent,
                        borderRadius: BorderRadius.circular(50),
                        border: isSelected ? Border.all(color: redActive, width: 2) : null,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        titles[index],
                        style: TextStyle(
                          color: isSelected ? redActive : greyInactive,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          // Contenu des onglets
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildInfoTab(),
                _buildHistoriqueTab(),
                _buildDocumentsTab(),
                _buildRdvTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --------- ONGLET INFO ---------
  Widget _buildInfoTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _infoSection(
            title: "Informations personnelles",
            children: [
              _infoRow("Date de naissance", "10/10/1960"),
              _infoRow("Sexe", "Masculin"),
              _infoRow("Adresse", "Sacré Cœur"),
              
              _infoRow("Maladie", "Aucune"),
            ],
          ),
          const SizedBox(height: 16),
          _infoSection(
            title: "Informations administratives",
            children: [
              _infoRow("Numéro dossier", "ID: 123456"),
              _infoRow("Couverture sociale", "Lorem"),
              
            ],
          ),
          const SizedBox(height: 16),
          _infoSection(
            title: "Informations médicales",
            children: [
              _infoRow("", ""),
              
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoSection({required String title, required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: TextStyle(color: HexColor('#285D90'), fontWeight: FontWeight.w700, fontSize: 18)),
        const SizedBox(height: 20),
        ...children,
      ]),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: HexColor('#212121'))),
          Text(value, style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15, color: HexColor('#5C738A'))),
        ],
      ),
    );
  }

  // --------- ONGLET HISTORIQUES ---------
  Widget _buildHistoriqueTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _historiqueSection(
            title: "Antécédents médicaux",
            iconPath: 'assets/icons/medic.png',
            actionLabel: "Modifier",
            items: [
              _historyItem(
                
                date: "Octobre 2022",
                title: "Diagnostic d'hypertension",
                description: "Tension artérielle 150/95 mmHg",
              ),
              _historyItem(
                
                date: "Mars 2021",
                title: "Appendicectomie",
                description: "Intervention sans complications",
              ),
               _historyItem(
                
                date: "Janvier 2020",
                title: "Fracture du poignet droit",
                description: "Suite a une chute,platre pendant 6 semaines",
              ),
            ],
          ),
          const SizedBox(height: 16),
          _historiqueSection(
            title: "Antécédents familiaux",
            iconPath: 'assets/icons/antec.png',
            actionLabel: "Modifier",
            items: [
              _historyItem(
              
                date: "Père",
                title: "Hypertension, Diabète type 2",
                description: "Âge : 65 ans",
              ),
              _historyItem(
                
                date: "Mère",
                title: "Cancer du sein (rémission)",
                description: "Âge : 62 ans",
              ),
              _historyItem(
                
                date: "Frere",
                title: "Asthme",
                description: "Âge : 42 ans",
              ),
            ],
          ),
          const SizedBox(height: 16),
          _historiqueSection(
            title: "Historique des consultations",
            iconPath: 'assets/icons/cons.png',
            actionLabel: "Ajouter",
            items: [
              _consultationItem(
                date: "15 juin 2025",
                doctor: "Dr. Lamine Diop",
                description:
                    "Patiente se présente pour son suivi trimestriel d'hypertension. Tension artérielle sous contrôle avec le traitement actuel. Pas d'effets secondaires signalés. Maintien du traitement actuel.",
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buttonPrimaryWithImage(text: "Créer un compte rendu", icon: Image.asset('assets/icons/fileedit.png')),
          const SizedBox(height: 8),
          _buttonSecondary(text: "Listez les comptes rendus", icon: Image.asset('rendu.png')),
        ],
      ),
    );
  }

  Widget _historiqueSection({
    required String title,
    required String iconPath,
    required String actionLabel,
    required List<Widget> items,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              children: [
                Image.asset(iconPath, height: 20, width: 20),
                const SizedBox(width: 8),
                Text(title, style: TextStyle(color: blueSectionTitle, fontWeight: FontWeight.w600, fontSize: 14)),
              ],
            ),
            Text(actionLabel, style: TextStyle(color: blueLight, fontWeight: FontWeight.w600, fontSize: 14)),
          ]),
          const SizedBox(height: 16),
          ...items,
        ],
      ),
    );
  }

  Widget _historyItem({ required String date, required String title, required String description}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(date, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
              const SizedBox(height: 4),
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF64B5F6),
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  decoration: TextDecoration.underline,
                ),
              ),
              const SizedBox(height: 4),
              Text(description, style: const TextStyle(color: Colors.black54, fontSize: 13)),
            ]),
          ),
        ],
      ),
    );
  }
  // --------- ONGLET DOCUMENTS ---------
  Widget _buildDocumentsTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Titre
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              "Documents du patient",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: blueSectionTitle,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Filtres onglets ovales
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFE5E7EB),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: List.generate(docTabs.length, (index) {
                final selected = _docTabIndex == index;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _docTabIndex = index),
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: selected ? redActive : Colors.transparent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        docTabs[index],
                        style: TextStyle(
                          color: selected ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),

          const SizedBox(height: 16),

          // Liste des documents
          _documentItem("Ordonnance", "15 Janvier 2023", iconPath: 'assets/icons/doc.svg'),
          _documentItem("Compte rendu", "12 Février 2023", iconPath: 'assets/icons/doc.svg'),
          _documentItem("Consultation initiale", "05 Mars 2023", iconPath: 'assets/icons/doc.svg'),

          const Spacer(),

          
        ],
      ),
    );
  }

  Widget _documentItem(String title, String date, {required String iconPath}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: blueLight.withOpacity(0.4)),
      ),
      child: Row(
        children: [
          Image.asset(iconPath, height: 24, width: 24),
          const SizedBox(width: 12),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
            const SizedBox(height: 4),
            Text(date, style: const TextStyle(color: Colors.black54, fontSize: 13)),
          ]),
        ],
      ),
    );
  }
  // --------- ONGLET RDV ---------
  Widget _buildRdvTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Titre
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              "Rendez-vous à venir",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: blueSectionTitle,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Liste des RDVs
          _rdvItem(
            iconPath: 'assets/icons/frame5.svg',
            title: "Consultation",
            datetime: "Sam. 13 septembre 2025, 10:00 - 12:00",
            
          ),
          _rdvItem(
            iconPath: 'assets/icons/frame5.svg',
            title: "Suivi patient",
            datetime: "Lun. 15 septembre 2025, 14:00 - 15:00",
            
          ),
          _rdvItem(
            iconPath: 'assets/icons/frame5.svg',
            title: "Consultation",
            datetime: "Lun. 15 septembre 2025, 16:00 - 17:00",
            
          ),

          const Spacer(),

          _buttonPrimaryWithImage(text: "Ajouter un rendez-vous",icon:Image.asset('assets/icons/plus.png')),
        ],
      ),
    );
  }

  Widget _rdvItem({
    required String iconPath,
    
    required String title,
    required String datetime,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Première icône personnalisée
          Image.asset(iconPath, height: 24, width: 24),
          const SizedBox(width: 14),

          // Ligne verticale fine
          Container(
            width: 1,
            height: 40,
            color: Colors.grey.shade300,
          ),
          const SizedBox(width: 14),

          // Texte
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                const SizedBox(height: 4),
                Text(datetime, style: const TextStyle(color: Colors.black54, fontSize: 13)),
              ],
            ),
          ),

          // Deuxième icône (séparée par ligne verticale)
          const SizedBox(width: 14),
          Container(
            width: 1,
            height: 40,
            color: Colors.grey.shade300,
          ),
          const SizedBox(width: 14),
          
        ],
      ),
    );
  }
  // --------- ITEM Consultation (Historique) ---------
  Widget _consultationItem({required String date, required String doctor, required String description}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(date, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
            Text(doctor, style: const TextStyle(color: Colors.black54, fontSize: 13)),
          ],
        ),
        const SizedBox(height: 8),
        Text(description, style: const TextStyle(color: Colors.black87, fontSize: 13)),
      ]),
    );
  }

  // --------- Bouton principal ---------
 Widget _buttonPrimaryWithImage({required String text, required Widget icon}) {
  return ElevatedButton.icon(
    onPressed: () {},
    style: ElevatedButton.styleFrom(
      backgroundColor: redActive,
      foregroundColor: Colors.white,
      minimumSize: const Size(double.infinity, 48),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    icon: icon,
    label: Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
    ),
  );
}


  // --------- Bouton secondaire ---------
 Widget _buttonSecondary({required String text, required Widget icon}) {
    return OutlinedButton.icon(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        foregroundColor: blueDark,
        side: BorderSide(color: blueDark, width: 1.5),
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      icon: icon,
      label: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
      ),
    );
  }
}