import 'package:flutter/material.dart';

class DisponibilitePage extends StatefulWidget {
  const DisponibilitePage({Key? key}) : super(key: key);

  @override
  State<DisponibilitePage> createState() => _DisponibilitePageState();
}

class _DisponibilitePageState extends State<DisponibilitePage> {
  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> centres = [
    {
      "name": "Centre Médical Saint-Louis",
      "address": "123 Avenue Léopold Sédar Senghor, Saint-Louis",
      "active": true,
    },
    {
      "name": "Clinique des Almadies",
      "address": "45 Route des Almadies, Dakar",
      "active": false,
    },
    {
      "name": "Hôpital Principal de Dakar",
      "address": "Avenue Nelson Mandela, Dakar",
      "active": true,
    },
  ];

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
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          // Champ de recherche
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Rechercher un centre de santé",
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          const SizedBox(height: 16),
          // Liste des centres
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: centres.length,
              itemBuilder: (context, index) {
                final centre = centres[index];
                if (_searchController.text.isNotEmpty &&
                    !centre["name"]
                        .toLowerCase()
                        .contains(_searchController.text.toLowerCase())) {
                  return const SizedBox.shrink();
                }

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F0FE),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.apartment,
                          color: Color(0xFF1E4777),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              centre["name"],
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              centre["address"],
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            centre["active"] ? "Actif" : "Inactif",
                            style: TextStyle(
                              color: centre["active"]
                                  ? Colors.green
                                  : Colors.red,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                          Switch(
                            value: centre["active"],
                            onChanged: (val) {
                              setState(() {
                                centre["active"] = val;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF1E4777),
        onPressed: () {
          // Action pour ajouter un nouveau centre
        },
        child: const Icon(Icons.add, size: 30),
      ),
    );
  }
}
