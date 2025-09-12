import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'dashboard.dart';

import '../utils/HexColor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('fr_FR', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RDV App',
      home: const ChoixDate(),
    );
  }
}

class ChoixDate extends StatefulWidget {
  final String initials;
  final String doctorName;
  final String specialty;
  final String clinic;

  const ChoixDate({
    super.key,
    this.initials = "AS",
    this.doctorName = "Dr. Aminata Sow",
    this.specialty = "Dermatologie",
    this.clinic = "Clinique des Almadies",
  });

  @override
  State<ChoixDate> createState() => _ChoixDateState();
}

class _ChoixDateState extends State<ChoixDate> {
  DateTime? selectedDate;
  String? selectedTime;
  TextEditingController reasonController = TextEditingController();

   void _showSuccessMessage() {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 300, // sort du bas
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: AnimatedOpacity(
            opacity: 1.0,
            duration: const Duration(milliseconds: 300),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: HexColor("#D4F0D6"),
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset('assets/icons/check.png'),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Rendez-vous Confirme",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Votre consultation a été programmee avec succès.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    // durée affichage puis redirection
    Future.delayed(const Duration(seconds: 2), () {
      overlayEntry.remove();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => DashboardPage(initialIndex: 1),
      ),
      (route) => false,
      );
    });
  }

  DateTime focusedMonth = DateTime.now();

  List<String> availableTimes = [
    '09:00', '09:30', '10:00',
    '10:30', '11:00', '11:30',
    '14:00', '14:30', '15:00',
    '15:30', '16:00', '16:30',
  ];

  bool get isValid =>
      selectedDate != null &&
      selectedTime != null &&
      reasonController.text.trim().isNotEmpty;

  List<DateTime> generateMonthDates(DateTime month) {
    final firstDay = DateTime(month.year, month.month, 1);
    final lastDay = DateTime(month.year, month.month + 1, 0);
    return List.generate(
      lastDay.day,
      (index) => DateTime(month.year, month.month, index + 1),
    );
  }

  List<DateTime> get availableDates => generateMonthDates(focusedMonth);

  void showSummaryModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor:Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: HexColor('#D1D5DB'),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Récapitulatif",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // ✅ Médecin
              infoRowWithIcon(
                iconPath: "assets/icons/medecin.png",
                label: "Médecin",
                value: "${widget.doctorName} - ${widget.specialty}",
              ),

              // ✅ Date & Heure
              infoRowWithIcon(
                iconPath: "assets/icons/date.png",
                label: "Date & Heure",
                value: "${DateFormat('EEEE d MMMM yyyy', 'fr_FR').format(selectedDate!)} à $selectedTime",
              ),

              // ✅ Lieu
              infoRowWithIcon(
                iconPath: "assets/icons/lieu.png",
                label: "Lieu",
                value: widget.clinic,
              ),

              // ✅ Motif
              infoRowWithIcon(
                iconPath: "assets/icons/motif.png",
                label: "Motif de la consultation",
                value: reasonController.text.trim(),
              ),

              const SizedBox(height: 16),

              // ✅ Encadré vert
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: HexColor('#1EA438'),
                  border: Border.all(color: HexColor('#1EA438')),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  "En confirmant ce rendez-vous, vous acceptez de vous présenter à l’heure indiquée. En cas d’empêchement, merci d’annuler au moins 24h à l’avance.",
                  style: TextStyle(
                    color: HexColor('#16A34A'),
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ✅ Boutons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: HexColor('#D1D5DB')),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text("Modifier",
                          style: TextStyle(
                              color: HexColor('#285D90'),
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _showSuccessMessage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: HexColor('#305579'),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text("Confirmer",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#F3F4F6'),
      appBar: AppBar(
        title: const Text("Choisir une date et heure"),
        backgroundColor: HexColor('#305579'),
        foregroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // ✅ Médecin Card
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: HexColor('#E9EFFD'),
                    child: Text(
                      widget.initials,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: HexColor('#2563EB'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.doctorName,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600)),
                        Text("${widget.specialty} • ${widget.clinic}",
                            style: TextStyle(
                                color: HexColor('#6B7280'), fontSize: 11)),
                      ],
                    ),
                  ),
                  Text("Disponible",
                      style: TextStyle(
                          color: HexColor('#16A34A'), fontSize: 11)),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // ✅ Calendrier
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Choisir une date",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios, size: 10),
                        onPressed: () {
                          setState(() {
                            focusedMonth = DateTime(
                                focusedMonth.year, focusedMonth.month - 1);
                            selectedDate = null;
                            selectedTime = null;
                          });
                        },
                      ),
                      Text(DateFormat.yMMMM('fr_FR').format(focusedMonth),
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 12)),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward_ios, size: 10),
                        onPressed: () {
                          setState(() {
                            focusedMonth = DateTime(
                                focusedMonth.year, focusedMonth.month + 1);
                            selectedDate = null;
                            selectedTime = null;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 70,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: availableDates.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 6),
                      itemBuilder: (_, index) {
                        final date = availableDates[index];
                        final isSelected = date.day == selectedDate?.day &&
                            date.month == selectedDate?.month &&
                            date.year == selectedDate?.year;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedDate = date;
                              selectedTime = null;
                            });
                          },
                          child: Container(
                            width: 55,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? HexColor('#285D90')
                                  : HexColor('#F3F4F6'),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    DateFormat.E('fr_FR')
                                        .format(date)
                                        .substring(0, 2),
                                    style: TextStyle(
                                        color: isSelected
                                            ? Colors.white
                                            : HexColor('#6B7280'),
                                        fontSize: 11)),
                                Text("${date.day}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: isSelected
                                            ? Colors.white
                                            : HexColor('#1F2937'))),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // ✅ Heures
            if (selectedDate != null)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Choisir une heure",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600)),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 6,
                        mainAxisSpacing: 6,
                        childAspectRatio: 3.0,
                      ),
                      itemCount: availableTimes.length,
                      itemBuilder: (context, index) {
                        final time = availableTimes[index];
                        final isSelected = time == selectedTime;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedTime = time;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? HexColor('#285D90')
                                  : HexColor('#F3F4F6'),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            alignment: Alignment.center,
                            child: Text(time,
                                style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : HexColor('#374151'),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12)),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 8),

          
            // ✅ Motif
if (selectedTime != null)
  Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Motif de la consultation",
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        SizedBox(
          height: 120, // 👉 taille réduite du champ
          child: TextField(
            
            controller: reasonController,
            onChanged: (_) => setState(() {}),
            maxLines: null,
            expands: true,
            decoration: InputDecoration(
              hintText:
                  "Décrivez brièvement le motif de votre consultation...",
              hintStyle: TextStyle(
                  color: HexColor('#6B7280'), fontSize: 13),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(color: HexColor('#DBEAFE')),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
      ],
    ),
  ),

            const SizedBox(height: 8),

            // ✅ Bouton Valider
            Container(
              height: 45,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: isValid
                    ? LinearGradient(
                        colors: [HexColor('#305579'), HexColor('#1E40AF')])
                    : null,
                color: isValid ? null : HexColor('#E5E7EB'),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ElevatedButton(
                onPressed: isValid ? showSummaryModal : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: Text(
                  "Valider",
                  style: TextStyle(
                      color: isValid
                          ? Colors.white
                          : HexColor('#9CA3AF'),
                      fontWeight: FontWeight.w600,
                      fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ✅ Fonction pour les lignes avec icônes
Widget infoRowWithIcon({
  required String iconPath,
  required String label,
  required String value,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(iconPath, width: 40, height: 40),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: TextStyle(
                      fontSize: 14,
                      color: HexColor('#636E72'),
                      fontWeight: FontWeight.w500)),
              const SizedBox(height: 2),
              Text(value,
                  style:  TextStyle(
                      fontSize: 16,
                      color: HexColor('#2D3436'),
                      fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ],
    ),
  );
}
