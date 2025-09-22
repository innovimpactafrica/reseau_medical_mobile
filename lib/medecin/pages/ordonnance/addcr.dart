import 'package:flutter/material.dart';

class CompteRenduModal extends StatefulWidget {
  @override
  _CompteRenduModalState createState() => _CompteRenduModalState();
}

class _CompteRenduModalState extends State<CompteRenduModal>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  String? _selectedCategory;

  final List<String> _categories = [
    'Consultation',
    'Suivi',
    'Urgence',
    'Autre',
  ];

  final TextEditingController _titreController = TextEditingController();
  final TextEditingController _texteController = TextEditingController();
  final TextEditingController _audioTitreController = TextEditingController();
  final TextEditingController _videoTitreController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _titreController.dispose();
    _texteController.dispose();
    _audioTitreController.dispose();
    _videoTitreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Taille max de la modale selon le contenu (variable selon onglet)
    double initialSize = 0.6;
    if (_tabController.index == 0) {
      initialSize = 0.7; // texte a plus de champs
    } else if (_tabController.index == 1) {
      initialSize = 0.6;
    } else {
      initialSize = 0.55;
    }

    return SafeArea(
      child: DraggableScrollableSheet(
        initialChildSize: initialSize,
        minChildSize: 0.4,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Drag handle
                Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 12),

                // Titre + bouton fermer
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Ajouter un compte rendu",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(Icons.close, size: 24),
                    )
                  ],
                ),
                const SizedBox(height: 16),

                // Onglets stylisés (background gris clair + onglet sélectionné marron arrondi)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.all(4),
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      color: Colors.brown.shade700,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black54,
                    labelStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    unselectedLabelStyle: const TextStyle(
                      fontSize: 14,
                    ),
                    tabs: const [
                      Tab(text: "Texte"),
                      Tab(text: "Audio"),
                      Tab(text: "Vidéo"),
                    ],
                    onTap: (_) {
                      setState(() {}); // pour recalcul taille modale si besoin
                    },
                  ),
                ),
                const SizedBox(height: 20),

                // Contenu avec scroll si besoin
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildTexteTab(scrollController),
                      _buildAudioTab(scrollController),
                      _buildVideoTab(scrollController),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Dropdown catégorie avec label
  Widget _buildCategoryDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Catégorie', style: _labelStyle),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          value: _selectedCategory,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            isDense: true,
          ),
          hint: const Text('Sélectionner'),
          items: _categories
              .map(
                (c) => DropdownMenuItem(value: c, child: Text(c)),
              )
              .toList(),
          onChanged: (val) {
            setState(() {
              _selectedCategory = val;
            });
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  // Onglet Texte
  Widget _buildTexteTab(ScrollController scrollController) {
    return SingleChildScrollView(
      controller: scrollController,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCategoryDropdown(),

          const Text("Titre du compte rendu", style: _labelStyle),
          const SizedBox(height: 6),
          _buildTextField(_titreController, "Saisir"),

          const SizedBox(height: 16),
          const Text("Texte", style: _labelStyle),
          const SizedBox(height: 6),
          _buildTextField(_texteController, "Saisir", maxLines: 5),

          const SizedBox(height: 24),

          _buildBottomButtons(),
        ],
      ),
    );
  }

  // Onglet Audio
  Widget _buildAudioTab(ScrollController scrollController) {
    return SingleChildScrollView(
      controller: scrollController,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCategoryDropdown(),

          const Text("Titre du compte rendu", style: _labelStyle),
          const SizedBox(height: 6),
          _buildTextField(_audioTitreController, "Saisir"),

          const SizedBox(height: 16),
          const Text("Audio", style: _labelStyle),
          const SizedBox(height: 6),

          Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Icon(Icons.graphic_eq, color: Colors.blue.shade700),
                ),
                IconButton(
                  icon: const Icon(Icons.mic, color: Colors.blue),
                  onPressed: () {
                    // TODO: démarrer enregistrement audio
                  },
                )
              ],
            ),
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // TODO: enregistrer l'audio
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text("Enregistrer"),
            ),
          ),

          const SizedBox(height: 12),

          OutlinedButton.icon(
            onPressed: () {
              // TODO: partager avec médecin
            },
            icon: const Icon(Icons.share, color: Colors.red),
            label: const Text(
              "Partager la fiche avec un médecin",
              style: TextStyle(color: Colors.red),
            ),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.red),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ],
      ),
    );
  }

  // Onglet Vidéo
  Widget _buildVideoTab(ScrollController scrollController) {
    return SingleChildScrollView(
      controller: scrollController,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCategoryDropdown(),

          const Text("Titre du compte rendu", style: _labelStyle),
          const SizedBox(height: 6),
          _buildTextField(_videoTitreController, "Saisir"),

          const SizedBox(height: 16),

          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade400),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.video_library_outlined,
                    size: 40, color: Colors.grey),
                const SizedBox(height: 8),
                const Text(
                  "Sélectionnez une vidéo de votre galerie",
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: () {
                    // TODO: choisir vidéo
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey.shade400),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 24,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text("Choisir une vidéo"),
                )
              ],
            ),
          ),

          const SizedBox(height: 24),

          _buildBottomButtons(),
        ],
      ),
    );
  }

  // Champs texte
  Widget _buildTextField(TextEditingController controller, String hintText,
      {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  // Boutons en bas communs aux onglets texte et vidéo
  Widget _buildBottomButtons() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              // TODO: enregistrer
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade700,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text(
              "Enregistrer",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {
              // TODO: partager
            },
            icon: const Icon(Icons.share, color: Colors.red),
            label: const Text(
              "Partager la fiche avec un médecin",
              style: TextStyle(color: Colors.red),
            ),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.red),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ),
      ],
    );
  }

  static const TextStyle _labelStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Colors.black87,
  );
}
