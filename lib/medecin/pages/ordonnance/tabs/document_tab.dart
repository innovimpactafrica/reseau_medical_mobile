import 'package:flutter/material.dart';
import '../../../utils/HexColor.dart';
import '../../ordonnance/new_ordonnance.dart'; // Import correct
import '../details_pordonnance.dart'; // Page de détail si nécessaire

class DocumentsTab extends StatefulWidget {
  final String doctorName;
  final String specialty;
  final String clinic;
  final String initials;
  final String patientName;
  final String patientInitials;
  final String patientDetails;

  const DocumentsTab({
    Key? key,
    required this.doctorName,
    required this.specialty,
    required this.clinic,
    required this.initials,
    required this.patientName,
    required this.patientInitials,
    required this.patientDetails,
  }) : super(key: key);

  @override
  State<DocumentsTab> createState() => _DocumentsTabState();
}

class _DocumentsTabState extends State<DocumentsTab> {
  int _selectedFilter = 0;
  final List<String> filters = ["Tous", "Examens", "Résultats", "Notes"];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF5F6FA),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
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
                    Text(
                      "Documents médicaux",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: HexColor('#285D90'),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Onglets filtres
                    Row(
                      children: List.generate(filters.length, (index) {
                        final bool isSelected = _selectedFilter == index;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(
                              filters[index],
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: isSelected
                                    ? Colors.white
                                    : HexColor('#305579'),
                              ),
                            ),
                            selected: isSelected,
                            selectedColor: HexColor('#B53C3A'),
                            backgroundColor: const Color(0xFFF2F4F7),
                            onSelected: (_) {
                              setState(() {
                                _selectedFilter = index;
                              });
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            visualDensity: VisualDensity.compact,
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 16),

                    // Liste des documents
                    _documentItem("Ordonnance", "15 Janvier 2023"),
                    _documentItem("Compte rendu", "15 Janvier 2023"),
                    _documentItem("Initial Consultation", "15 Janvier 2023"),
                  ],
                ),
              ),
            ),
          ),

          // Boutons d’action
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF305579),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    icon: Image.asset('assets/icons/fileedit.png'),
                    label: const Text(
                      "Prescrire une ordonnance",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => NewOrdonnancePage(
                            doctorName: widget.doctorName,
                            specialty: widget.specialty,
                            clinic: widget.clinic,
                            initials: widget.initials,
                            patientName: widget.patientName,
                            patientInitials: widget.patientInitials,
                            patientDetails: widget.patientDetails,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: HexColor('#DADADA')),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {},
                    icon: Image.asset('assets/icons/send.png',
                        width: 20, height: 20),
                    label: Text(
                      "Partager la fiche avec un medecin",
                      style:
                          TextStyle(color: HexColor('#B53C3A'), fontSize: 15),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _documentItem(String title, String date) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => NewOrdonnancePage(
              doctorName: widget.doctorName,
              specialty: widget.specialty,
              clinic: widget.clinic,
              initials: widget.initials,
              patientName: widget.patientName,
              patientInitials: widget.patientInitials,
              patientDetails: widget.patientDetails,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F6FA),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Image.asset(
                  "assets/icons/frame.png",
                  width: 35,
                  height: 35,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 15),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    date,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
