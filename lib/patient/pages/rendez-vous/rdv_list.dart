import 'package:flutter/material.dart';
import '../../utils/HexColor.dart';
import 'rdv_detail.dart';

class MesRendezVousPage extends StatelessWidget {
  const MesRendezVousPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: HexColor("#F9FAFB"),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ---- HEADER ----
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
              color: HexColor("#305579"),
              child: const Text(
                "Mes Rendez-vous",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            /// ---- Onglets ----
            TabBar(
              indicatorColor: HexColor("#285D90"),
              labelColor: HexColor("#285D90"),
              unselectedLabelColor: HexColor("#888888"),
              labelStyle: const TextStyle(fontWeight: FontWeight.w600),
              tabs: const [
                Tab(text: "À venir(0)"),
                Tab(text: "Terminés(0)"),
                Tab(text: "Annulés(0)"),
              ],
            ),

            /// ---- Contenu des onglets ----
            Expanded(
              child: TabBarView(
                children: [
                  /// Onglet À venir
                  ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      /// ---- Carte RDV en attente ----
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => RdvDetailPage(
                                medecin: "Dr. Lamine DIOP",
                                specialite: "Cardiologie",
                                dateHeure: "Jeudi 15 juin - 10:30",
                                lieu: "Centre Médical Saint-Louis",
                                motif: "Consultation générale",
                                status: "En attente",
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// Ligne profil + nom + statut
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: HexColor("#E9EFFD"),
                                    child: Text(
                                      "LD",
                                      style: TextStyle(
                                        color: HexColor('#2563EB'),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Dr. Lamine DIOP",
                                          style: TextStyle(
                                            color: HexColor('#111827'),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          "Cardiologie",
                                          style: TextStyle(
                                            color: HexColor('#6B7280'),
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: HexColor("#FEF9C3"),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      "En attente",
                                      style: TextStyle(
                                        color: HexColor("#854D0E"),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 16),

                              /// Ligne date + heure
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Jeudi 15 juin",
                                        style: TextStyle(
                                          color: HexColor('#111827'),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "Centre Médical Saint-Louis",
                                        style: TextStyle(
                                          color: HexColor('#4B5563'),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "10:30",
                                    style: TextStyle(
                                      color: HexColor('#111827'),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 16),

                              /// Boutons confirmer / reporter
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: HexColor("#2563EB"),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12),
                                      ),
                                      child: const Text(
                                        "Confirmer",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: HexColor("#E9EFFD"),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12),
                                      ),
                                      child: Text(
                                        "Reporter",
                                        style: TextStyle(
                                          color: HexColor("#2563EB"),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      /// ---- Carte RDV confirmé ----
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// Ligne profil + nom + statut
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: HexColor("#E9EFFD"),
                                  child: Text(
                                    "AS",
                                    style: TextStyle(
                                      color: HexColor('#2563EB'),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        "Dr. Aminata Sow",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        "Confirmé",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: HexColor("#DCFCE7"),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    "Confirmé",
                                    style: TextStyle(
                                      color: HexColor("#166534"),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 16),

                            /// Ligne date + heure
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: const [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Jeudi 15 juin",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "Clinique des Almadies",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "10:30",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  /// Onglet Terminés
                  const Center(child: Text("Aucun rendez-vous terminé")),

                  /// Onglet Annulés
                  const Center(child: Text("Aucun rendez-vous annulé")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
