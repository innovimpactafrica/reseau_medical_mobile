import 'package:flutter/material.dart';
import 'package:rmelapp/medecin/widgets/add_disponibilite_modal.dart';
import '../models/centre_modal.dart';
import '../widgets/centre_card.dart';
import '../widgets/centre_details_modal.dart';
import '../utils/HexColor.dart';

class DisponibilitePage extends StatefulWidget {
  const DisponibilitePage({Key? key}) : super(key: key);

  @override
  State<DisponibilitePage> createState() => _DisponibilitePageState();
}

class _DisponibilitePageState extends State<DisponibilitePage> {
  final TextEditingController _searchController = TextEditingController();
  Centre? _selectedCentre; // Centre sélectionné pour la modale

  List<Centre> centres = [
    Centre(
      name: "Centre Médical Saint-Louis",
      address: "123 Avenue Léopold Sédar Senghor, Saint-Louis",
      active: true,
      disponibilites: [
        Disponibilite(
          centreName: "Centre Médical Saint-Louis",
          jour: "Mardi",
          heureDebut: "09:00",
          heureFin: "17:00",
          dureeConsultation: "45min",
        ),
        Disponibilite(
          centreName: "Centre Médical Saint-Louis",
          jour: "Jeudi",
          heureDebut: "09:00",
          heureFin: "17:00",
          dureeConsultation: "45min",
        ),
      ],
    ),
    Centre(
      name: "Clinique des Almadies",
      address: "45 Route des Almadies, Dakar",
      active: false,
      disponibilites: [],
    ),
    Centre(
      name: "Hôpital Principal de Dakar",
      address: "Avenue Nelson Mandela, Dakar",
      active: true,
      disponibilites: [],
    ),
  ];

  /// Ouvre la modale des détails d’un centre
  void _openDetailsModal(Centre centre) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => CentreDetailsModal(
        centre: centre,
        onUpdate: () => setState(() {}),
      ),
    );
  }

  /// Ouvre la modale d’ajout de disponibilité
  void _showAddDisponibiliteModal(BuildContext context, String centreName) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => AddDisponibiliteModal(
        centreName: centreName,
        onSave: (jour, debut, fin, duree) {
          // Ici on peut ajouter la dispo au centre
          print("Nouvelle dispo: $jour, $debut - $fin, durée $duree");
          Navigator.pop(context);
        },
        onCancel: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (centres.isNotEmpty) {
      _selectedCentre = centres[0]; // sélection automatique du premier centre
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E4777),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Affiliations",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Rechercher un centre de santé",
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) => setState(() {}),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: centres.length,
              itemBuilder: (context, index) {
                final centre = centres[index];
                if (_searchController.text.isNotEmpty &&
                    !centre.name
                        .toLowerCase()
                        .contains(_searchController.text.toLowerCase())) {
                  return const SizedBox.shrink();
                }

                return GestureDetector(
                  onTap: () {
                    _selectedCentre = centre;
                    _openDetailsModal(centre);
                  },
                  child: CentreCard(
                    centre: centre,
                    onToggleActive: (bool value) {
                      setState(() {
                        centre.active = value;
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _selectedCentre != null
            ? () =>
                _showAddDisponibiliteModal(context, _selectedCentre!.name)
            : null,
        elevation: 0,
        backgroundColor: _selectedCentre != null
            ? Colors.transparent
            : Colors.grey[400],
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            gradient: _selectedCentre != null
                ? LinearGradient(
                    colors: [HexColor('#2563EB'), HexColor('#1D4ED8')],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}
