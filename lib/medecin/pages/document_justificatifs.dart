import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:io';
import '../utils/HexColor.dart';
import '../utils/constant.dart';
import 'package:rmelapp/medecin/pages/verification_doctor.dart';

class DocumentsJustificatifsPage extends StatefulWidget {
  const DocumentsJustificatifsPage({Key? key}) : super(key: key);

  @override
  State<DocumentsJustificatifsPage> createState() =>
      _DocumentsJustificatifsPageState();
}




class _DocumentsJustificatifsPageState extends State<DocumentsJustificatifsPage> {
  File? pieceIdentite;
  File? certificatOrdre;
    


  void _showSuccessMessage() {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 200, // sort du bas
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: AnimatedOpacity(
            opacity: 1.0,
            duration: const Duration(milliseconds: 300),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
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
                    "Inscription envoyee avec succes !",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Votre demande d'inscription a été transmise à notre équipe. Vous recevrez un e-mail de confirmation une fois votre compte validé.",
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
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Verificationdoctor()),
      );
    });
  }



  Future<void> pickFile(bool isPieceIdentite) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
      withData: true,
    );

    if (result != null && result.files.first.size <= 5 * 1024 * 1024) {
      setState(() {
        if (isPieceIdentite) {
          pieceIdentite = File(result.files.single.path!);
        } else {
          certificatOrdre = File(result.files.single.path!);
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Fichier invalide ou trop volumineux (> 5MB)")),
      );
    }
  }

  Widget buildUploadBox({
    required String title,
    required String description,
    required File? file,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFD1D5DB)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
             SvgPicture.asset('assets/icons/piece.svg', color: Color(0xFF305579),),
            const SizedBox(height: 12),
            Text(
              file == null ? title : file.path.split('/').last,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: file == null ? const Color(0xFF305579) : Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: const TextStyle(
                color: Color(0xFF6B7280),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
              "Documents justificatifs",
              style: TextStyle(
                color: HexColor('#1E3A8A'),
                fontWeight: FontWeight.w700,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 8),
             Text(
              "Ces fichiers permettront de valider votre profil.",
              style: TextStyle(fontSize: 16, color: HexColor('#6C7278')),
            ),
            const SizedBox(height: 24),

            // Upload pièce d'identité
             Text("Pièce d'identité", style: TextStyle(color:HexColor('#343A40') ,fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            buildUploadBox(
              title: "Cliquez pour télécharger votre pièce d'identité",
              description: "Formats acceptés: PDF, JPG, PNG (max. 5MB)",
              file: pieceIdentite,
              onTap: () => pickFile(true),
            ),

            // Upload certificat
             Text("Certificat d'inscription à l'Ordre", style: TextStyle(color:HexColor('#343A40'),fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            buildUploadBox(
              title: "Cliquez pour télécharger votre certificat",
              description: "Formats acceptés: PDF, JPG, PNG (max. 5MB)",
              file: certificatOrdre,
              onTap: () => pickFile(false),
            ),

            const SizedBox(height: 12),

            // Soumettre
            // Soumettre
ElevatedButton(
  onPressed: () {
    // ⚡ Ici on appelle directement la fonction de succès
    _showSuccessMessage();

    // Tu peux aussi déclencher l’upload si les fichiers existent
    if (pieceIdentite != null || certificatOrdre != null) {
      // TODO: Upload logique quand les fichiers sont fournis
      debugPrint("Upload fichiers : ${pieceIdentite?.path}, ${certificatOrdre?.path}");
    } else {
      debugPrint("Aucun fichier fourni, inscription envoyée quand même.");
    }
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF305579),
    minimumSize: const Size.fromHeight(50),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ),
  child:  Text("Soumettre", style: TextStyle(color:HexColor('#FFFFFF') ,fontSize: 16)),
),


            const SizedBox(height: 12),

            // Compléter plus tard
            OutlinedButton(
              onPressed: () {
                // Action "compléter plus tard"
                Navigator.pop(context);
              },
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                side: const BorderSide(color: Color(0xFFD1D5DB)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text("Compléter  plus tard", style: TextStyle(color: Colors.black)),
            ),

            const SizedBox(height: 20),

            // Bas de page
             Center(
              child: Text(
                "Vous pouvez compléter les documents plus tard depuis votre profil.",
                style: TextStyle(fontSize: 14, color: HexColor('#888888')),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height:50),

            // Connexion
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Déjà inscrit ? "),
                GestureDetector(
                  onTap: () {
                  
                          Navigator.pushNamed(context, "/connexion");
                  
                    // Aller à la page de connexion
                  },
                  child:  Text(
                    "Se connecter",
                    style: TextStyle(
                      color: HexColor('#B53C3A'),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
