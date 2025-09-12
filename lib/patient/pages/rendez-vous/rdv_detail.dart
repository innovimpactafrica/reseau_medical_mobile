import 'package:flutter/material.dart';
import '../../utils/HexColor.dart';
import '../choix_date.dart';
import '../../widgets/chat.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RdvDetailPage extends StatefulWidget {
  final String medecin;
  final String specialite;
  final String dateHeure;
  final String lieu;
  final String motif;
  final String status;

  const RdvDetailPage({
    super.key,
    required this.medecin,
    required this.specialite,
    required this.dateHeure,
    required this.lieu,
    required this.motif,
    required this.status,
  });

  @override
  State<RdvDetailPage> createState() => _RdvDetailPageState();
}

class _RdvDetailPageState extends State<RdvDetailPage> {
  late String medecin;
  late String specialite;
  late String dateHeure;
  late String lieu;
  late String motif;
  late String status;

  @override
  void initState() {
    super.initState();
    medecin = widget.medecin;
    specialite = widget.specialite;
    dateHeure = widget.dateHeure;
    lieu = widget.lieu;
    motif = widget.motif;
    status = widget.status;
  }

  Color _statusColor() {
    switch (status.toLowerCase()) {
      case "en attente":
        return HexColor("#FEF9C3");
      case "confirmé":
        return HexColor("#DCFCE7");
      case "annulé":
        return HexColor("#FEE2E2");
      default:
        return Colors.grey;
    }
  }

  Color _statusTextColor() {
    switch (status.toLowerCase()) {
      case "en attente":
        return HexColor("#854D0E");
      case "confirmé":
        return HexColor("#166534");
      case "annulé":
        return HexColor("#991B1B");
      default:
        return Colors.black;
    }
  }
void _showModal({
  required BuildContext context,
  required String title,
  required String actionWord, // "confirmer" ou "annuler"
  required VoidCallback onConfirm,
  required String confirmLabel,
  Color? confirmColor,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Petit trait en haut
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),

          // Titre
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 12),

          // Message
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'Êtes-vous sûr de vouloir ',
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 15,
              ),
              children: [
                TextSpan(
                  text: actionWord,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: confirmColor ?? HexColor("#305579"),
                  ),
                ),
                const TextSpan(text: ' ce rendez-vous ?'),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Séparateur
          Container(height: 1, color: HexColor("#E5E7EB")),

          // Boutons
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Annuler"),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.grey[600],
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
              Container(width: 1, height: 48, color: HexColor("#E5E7EB")),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    onConfirm();
                  },
                  child: Text(confirmLabel),
                  style: TextButton.styleFrom(
                    foregroundColor: confirmColor ?? HexColor("#305579"),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}


 void _showCustomSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset('assets/icons/check.png', color: HexColor("#22C55E")),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: HexColor("#2D3436"),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
      duration: const Duration(seconds: 3),
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#F3F4F6'),
      appBar: AppBar(
        backgroundColor: HexColor('#305579'),
        leading: const BackButton(color: Colors.white),
        title: const Text("Détails du rendez-vous", style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ligne Médecin + Statut
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: infoRowWithIcon("assets/icons/medecin.png", "Médecin", "$medecin - $specialite"),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 6),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: _statusColor(),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(color: _statusTextColor(), fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),

              infoRowWithIcon("assets/icons/date.png", "Date & Heure", dateHeure),
              infoRowWithIcon("assets/icons/lieu.png", "Lieu", lieu),
              infoRowWithIcon("assets/icons/motif.png", "Motif de la consultation", motif),

              const SizedBox(height: 16),

              // Informations importantes
              Container(
  width: double.infinity,
  padding: const EdgeInsets.all(12),
  margin: const EdgeInsets.only(bottom: 16),
  decoration: BoxDecoration(
    color: HexColor("#FEFCE8"),
    borderRadius: BorderRadius.circular(12),
  ),
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SvgPicture.asset("assets/icons/frame.svg", width: 24, height: 24),
      const SizedBox(width: 8),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Informations importantes",
              style: TextStyle(
                color: HexColor('#854D0E'),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Apporter les résultats de la dernière analyse sanguine et la liste des médicaments actuels.",
              style: TextStyle(
                fontSize: 12,
                color: HexColor("#2D3436"),
              ),
            ),
          ],
        ),
      ),
    ],
  ),
),


              // Documents à apporter
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: HexColor("#EFF6FF"),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset("assets/icons/file.svg", width: 24, height: 24),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:  [
                          Text("Documents à apporter", style: TextStyle(color:HexColor('#2563EB'),fontWeight: FontWeight.bold)),
                          SizedBox(height: 4),
                          Text("Résultats analyses",style: TextStyle(color:HexColor('#2D3436'),fontSize: 14)),
                          Text("Ordonnance précédente",style: TextStyle(color:HexColor('#2D3436'),fontSize:14 )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Boutons centrés et largeur pleine
              ElevatedButton.icon(
                onPressed: () {
                 _showModal(
  context: context,
  title: "Confirmer le RDV ?",
  actionWord: "confirmer",
  confirmLabel: "Confirmer",
  confirmColor: HexColor("#305579"),
  onConfirm: () {
    _showCustomSnackBar(context, "Rendez-vous confirmé");
  },
);

                },
                icon: Image.asset("assets/icons/checks.png", width: 20, height: 20),
                label:  Text("Confirmer ma présence",style: TextStyle(color: HexColor('#FFFFFF'),fontSize: 16),),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: HexColor("#305579"),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),

              const SizedBox(height: 12),

              ElevatedButton.icon(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChoixDate(
                        doctorName: medecin,
                        specialty: specialite,
                        clinic: lieu,
                      ),
                    ),
                  );

                  if (result != null) {
                    setState(() {
                      medecin = result['doctorName'];
                      specialite = result['specialty'];
                      dateHeure = result['dateHeure'];
                      lieu = result['clinic'];
                      motif = result['motif'];
                    });
                  }
                },
                icon: SvgPicture.asset("assets/icons/edit.svg", width: 20, height: 20),
                label:  Text("Modifier",style: TextStyle( color: HexColor('#285D90'),fontSize:16),),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: Colors.white,
                
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  side: BorderSide(
        color: HexColor('#285D90'),              // couleur de la bordure
        width: 1,                        // largeur de la bordure
      ),
                ),
              ),

              const SizedBox(height: 12),

              ElevatedButton.icon(
                onPressed: () {
                  _showModal(
  context: context,
  title: "Annuler le RDV ?",
  actionWord: "annuler",
  confirmLabel: "Annuler",
  confirmColor: HexColor("#D14343"),
  onConfirm: () {
    _showCustomSnackBar(context, "Rendez-vous annulé");
  },
);
                },
                icon: Image.asset("assets/icons/close.png", width: 20, height: 20),
                label: const Text("Annuler le rendez-vous"),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor:Colors.white,
                  foregroundColor: HexColor("#DC2626"),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  side: BorderSide(
        color: HexColor('#FECACA')   ,       // couleur de la bordure
        width: 1,                        // largeur de la bordure
      ),
                ),
              ),

              const SizedBox(height: 12),

              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatPage()));
                },
                icon: SvgPicture.asset("assets/icons/chat.svg", width: 20, height: 20,color: HexColor('#305579'),),
                
                label: const Text("Contacter le médecin"),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: HexColor("#FFFFFF"),
                  foregroundColor: HexColor('#305579'),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),

              const SizedBox(height: 12),

              ElevatedButton.icon(
                onPressed: () {
                  
                },
                icon: SvgPicture.asset("assets/icons/call.svg", width: 20, height: 20,color: HexColor('#305579'),),
                label: const Text("Appeler le centre médical"),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: HexColor("#FFFFFF"),
                  foregroundColor: HexColor('#305579'),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget utilitaire pour lignes info + icône
Widget infoRowWithIcon(String iconPath, String label, String value) {
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
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: HexColor('#636E72'),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  color: HexColor('#2D3436'),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
