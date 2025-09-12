import 'dart:async';
import 'package:flutter/material.dart';
import '../utils/HexColor.dart';
import 'motdepasse.dart';

class Verificationdoctor extends StatefulWidget {
  const Verificationdoctor({super.key});

  @override
  State<Verificationdoctor> createState() => _VerificationdoctorState();
}

class _VerificationdoctorState extends State<Verificationdoctor> {
  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());

  int _secondsRemaining = 30;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  @override
  void dispose() {
    for (var c in _controllers) c.dispose();
    _timer?.cancel();
    super.dispose();
  }

  // ----- OTP Logic -----
  void _onKeyTap(String digit) {
    for (int i = 0; i < _controllers.length; i++) {
      if (_controllers[i].text.isEmpty) {
        _controllers[i].text = digit;
        break;
      }
    }
    _checkOTPCompletion();
    setState(() {});
  }

  void _onBackspace() {
    for (int i = _controllers.length - 1; i >= 0; i--) {
      if (_controllers[i].text.isNotEmpty) {
        _controllers[i].clear();
        break;
      }
    }
    setState(() {});
  }

  void _checkOTPCompletion() {
    if (_controllers.every((c) => c.text.isNotEmpty)) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const Motdepasse()),
      );
    }
  }

  void _startCountdown() {
    _secondsRemaining = 30;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        timer.cancel();
      } else {
        setState(() {
          _secondsRemaining--;
        });
      }
    });
  }

  // ----- OTP Input Field -----
  Widget _buildOTPField(int index) {
    return SizedBox(
      width: 48,        // ✅ largeur des cases OTP
      height: 48,       // ✅ hauteur des cases OTP
      child: TextField(
        controller: _controllers[index],
        readOnly: true,
        showCursor: false,
        enableInteractiveSelection: false,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: TextStyle(
          fontSize: 18,               // ✅ taille du chiffre affiché
          color: HexColor("#212121"), // 🎨 couleur du texte OTP
        ),
        decoration: InputDecoration(
          counterText: "",
          filled: true,
          fillColor: HexColor("#F1F2F6"), // 🎨 fond des cases OTP
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),      // ✅ arrondi des coins
            borderSide: BorderSide(color: HexColor("#F1F2F6")), // 🎨 couleur bordure
          ),
          contentPadding: EdgeInsets.zero,
        ),
        onTap: () {
          if (_controllers[index].text.isNotEmpty) {
            _controllers[index].clear();
            setState(() {});
          }
        },
      ),
    );
  }

  // ----- Touche Clavier -----
  Widget _buildKey(String digit, {String? letters, VoidCallback? onPressed}) {
    final handler = onPressed ?? () => _onKeyTap(digit);
    return ElevatedButton(
      onPressed: handler,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // ✅ coins clavier
        ),
        backgroundColor: HexColor('#EBEFF2'),      // 🎨 fond touche clavier
        foregroundColor: HexColor('#333333'),             // 🎨 couleur du texte
        elevation: 0,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              digit,
              style: const TextStyle(
                fontSize: 28.67,      // ✅ taille du chiffre
                fontWeight: FontWeight.w600,
              ),
            ),
            if (letters != null && letters.isNotEmpty)
              Text(
                letters,
                style:  TextStyle(
                  fontSize: 10,    // ✅ taille des lettres
                  fontWeight: FontWeight.w400,
                  color: HexColor('#333333'), // 🎨 couleur des lettres ABC/DEF...
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBlankKey() => const SizedBox.shrink();

  // ----- Clavier Numérique -----
  Widget _buildNumberPad() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(1, 2, 1, 1), // ✅ marges du clavier
      child: GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 8,     // ✅ espace vertical entre touches
        crossAxisSpacing: 8,    // ✅ espace horizontal entre touches
        childAspectRatio: 2,    // ✅ forme des touches (1 = carré, >1 = plat)
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _buildKey('1'),
          _buildKey('2', letters: 'ABC'),
          _buildKey('3', letters: 'DEF'),
          _buildKey('4', letters: 'GHI'),
          _buildKey('5', letters: 'JKL'),
          _buildKey('6', letters: 'MNO'),
          _buildKey('7', letters: 'PQRS'),
          _buildKey('8', letters: 'TUV'),
          _buildKey('9', letters: 'WXYZ'),
          _buildBlankKey(),
          _buildKey('0'),
        ],
      ),
    );
  }

  // ----- UI principale -----
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 🎨 fond de la page
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white, // 🎨 fond de l’app bar
        leading: IconButton(
          icon:  Icon(Icons.arrow_back, color: HexColor('#1E3A8A')), // 🎨 couleur flèche retour
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8), // ✅ marges page
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Vérification OTP", // 🟢 titre principal
                style: TextStyle(
                  fontSize: 28,           // ✅ taille du titre
                  fontWeight: FontWeight.bold,
                  color: HexColor("#1E3A8A"), // 🎨 couleur du titre
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Veuillez entrer le code à 4 chiffres envoyé par SMS au +221 78 1XX XX XX", // 🟢 sous-texte
                style: TextStyle(
                  fontSize: 14,             // ✅ taille sous-texte
                  color: HexColor("#6C7278"), // 🎨 couleur sous-texte
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, // ✅ position des cases OTP
                children: List.generate(4, (index) => _buildOTPField(index)),
              ),
              const SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    Text(
                      "Vous n’avez pas reçu de code ?", // 🟢 message info
                      style: TextStyle(
                        fontSize: 15,
                        color: HexColor("#212121"), // 🎨 couleur du texte info
                      ),
                    ),
                    const SizedBox(height: 6),
                    GestureDetector(
                      onTap: _secondsRemaining == 0
                          ? () {
                              _startCountdown();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Nouveau code envoyé")), // 🟢 message snackbar
                              );
                            }
                          : null,
                      child: Text(
                        _secondsRemaining > 0
                            ? "Renvoyer dans (${_secondsRemaining}s)" // 🟢 compteur
                            : "Renvoyer le code ",                    // 🟢 lien actif
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: _secondsRemaining > 0
                              ? HexColor("#B0B0B0") // 🎨 gris désactivé
                              : HexColor("#2C7BE5"), // 🎨 couleur doré actif
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
            
    
              _buildNumberPad(), // ✅ Clavier numérique en bas de l’écran
            ],
          ),
        ),
      ),
    );
  }
}
