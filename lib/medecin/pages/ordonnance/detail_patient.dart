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
    // sécurité : s'assurer que l'index est dans l'intervalle (au cas où)
    final currentTabIndex = (_tabController.index >= 0 && _tabController.index < 4) ? _tabController.index : 0;

    return Scaffold(
      backgroundColor: lightGreyBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // icône de retour blanche (demandée)
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
        title: Padding(
          padding: const EdgeInsets.only(left: 0),
          child: const Text(
            "Détails Patient",
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        // je conserve l'ancienne action si tu en avais besoin
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
          // Section photo + nom + ID (conservée)
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

          // Onglets personnalisés (modification : plus d'ovale plein, juste trait rouge)
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(4, (index) {
                final titles = ["Info", "Historiques", "Documents", "RDV"];
                final isSelected = currentTabIndex == index;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => _tabController.animateTo(index),
                    behavior: HitTestBehavior.opaque,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            titles[index],
                            style: TextStyle(
                              color: isSelected ? redActive : greyInactive,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        // trait rouge uniquement pour l'onglet sélectionné
                        Container(
                          height: 3,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: isSelected ? redActive : Colors.transparent,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),

          // Contenu des onglets (conservé, avec ajustements demandés)
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
              // tu peux ajouter ici les lignes médicales supplémentaires
              _infoRow("Allergies", "Aucune"),
              _infoRow("Groupe sanguin", "O+"),
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
          // Antécédents médicaux (titre + items conservés, items modifiés pour titre/date sur même ligne)
          _historiqueSectionWithIcon(
            title: "Antécédents médicaux",
            iconPath: 'assets/icons/medic.png',
            actionLabel: "Modifier",
            items: [
              // chaque item : title + date sur la même ligne (date à droite), description en dessous
              _historyItem(
                date: "Octobre 2022",
                title: "Diagnostic d'hypertension",
                description: "Tension artérielle 150/95 mmHg",
                mode: "medical",
              ),
              _historyItem(
                date: "Mars 2021",
                title: "Appendicectomie",
                description: "Intervention sans complications",
                mode: "medical",
              ),
              _historyItem(
                date: "Janvier 2020",
                title: "Fracture du poignet droit",
                description: "Suite à une chute, plâtre pendant 6 semaines",
                mode: "medical",
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Antécédents familiaux (title à gauche, description (âge) sur la même ligne à droite)
          _historiqueSectionWithIcon(
            title: "Antécédents familiaux",
            iconPath: 'assets/icons/antec.png',
            actionLabel: "Modifier",
            items: [
              _historyItem(
                date: "", // non utilisé dans ce mode
                title: "Père : Hypertension, Diabète",
                description: "Âge : 65 ans",
                mode: "family",
              ),
              _historyItem(
                date: "",
                title: "Mère : Cancer du sein (rémission)",
                description: "Âge : 62 ans",
                mode: "family",
              ),
              _historyItem(
                date: "",
                title: "Frère : Asthme",
                description: "Âge : 42 ans",
                mode: "family",
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Historique des consultations (conservé ; icônes alignées à droite sous le texte)
          _historiqueSectionWithIcon(
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
              // tu peux ajouter d'autres consultations ici si besoin
            ],
          ),
          const SizedBox(height: 20),

          // Boutons (création + liste) - conservés
          _buttonPrimaryWithImage(text: "Créer un compte rendu", icon: Image.asset('assets/icons/fileedit.png')),
          const SizedBox(height: 8),
          _buttonSecondary(text: "Listez les comptes rendus", icon: Image.asset('assets/icons/rendu.png')),
        ],
      ),
    );
  }

  Widget _historiqueSectionWithIcon({
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

  // history item polyvalent (modes : "medical", "family", fallback)
  Widget _historyItem({
    required String date,
    required String title,
    required String description,
    String mode = "medical",
  }) {
    // Mode médical : title (gauche) + date (droite) sur la même ligne, description en dessous
    if (mode == "medical") {
      return Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                ),
                const SizedBox(width: 8),
                Text(date, style: const TextStyle(color: Colors.black54, fontSize: 13)),
              ],
            ),
            if (description.isNotEmpty) ...[
              const SizedBox(height: 6),
              Text(description, style: const TextStyle(color: Colors.black54, fontSize: 13)),
            ],
          ],
        ),
      );
    }

    // Mode family : title (gauche) + description (âge) sur la même ligne
    if (mode == "family") {
      return Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14))),
            const SizedBox(width: 8),
            Text(description, style: const TextStyle(color: Colors.black54, fontSize: 13)),
          ],
        ),
      );
    }

    // fallback : ancien style (au cas où)
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
      ]),
    );
  }

  // --------- ONGLET DOCUMENTS ---------
  Widget _buildDocumentsTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Titre
          Text(
            "Documents du patient",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: blueSectionTitle,
            ),
          ),
          const SizedBox(height: 12),

          // Filtres onglets alignés sur la même ligne (séparés)
          Row(
            children: List.generate(docTabs.length, (index) {
              final selected = _docTabIndex == index;
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _docTabIndex = index),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: selected ? redActive : Colors.transparent, width: 2),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      docTabs[index],
                      style: TextStyle(
                        color: selected ? redActive : Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 16),

          // Liste des documents (tous dans le même container)
          _documentItem("Ordonnance", "15 Janvier 2023", iconPath: 'assets/icons/doc.svg'),
          _documentItem("Compte rendu", "12 Février 2023", iconPath: 'assets/icons/doc.svg'),
          _documentItem("Consultation initiale", "05 Mars 2023", iconPath: 'assets/icons/doc.svg'),
          const SizedBox(height: 8),

          // si tu veux un bouton ici, on peut le remettre ; je garde la structure (tu avais un Spacer avant)
        ]),
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

          // Liste des RDVs (conservée)
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

          _buttonPrimaryWithImage(text: "Ajouter un rendez-vous", icon: Image.asset('assets/icons/plus.png')),
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
        const SizedBox(height: 8),
        // Trois icônes alignées à droite (demandé)
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Icon(Icons.edit, color: blueLight, size: 20),
          const SizedBox(width: 12),
          Icon(Icons.delete, color: Colors.redAccent, size: 20),
          const SizedBox(width: 12),
          Icon(Icons.share, color: blueDark, size: 20),
        ]),
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
