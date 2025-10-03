// compte_rendu_modal.dart
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rmelapp/medecin/utils/Hexcolor.dart';

class CompteRenduModal extends StatefulWidget {
  const CompteRenduModal({super.key});

  @override
  State<CompteRenduModal> createState() => _CompteRenduModalState();
}

class _CompteRenduModalState extends State<CompteRenduModal>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  String? _selectedCategory;
  final List<String> _categories = ['Consultation', 'Suivi', 'Urgence', 'Autre'];

  final TextEditingController _titreController = TextEditingController();
  final TextEditingController _texteController = TextEditingController();
  final TextEditingController _audioTitreController = TextEditingController();
  final TextEditingController _videoTitreController = TextEditingController();

  // Audio
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  final FlutterSoundPlayer _player = FlutterSoundPlayer();
  bool _isRecorderInitialized = false;
  bool _isRecording = false;
  bool _isPlaying = false;
  String? _audioPath;

  // Waveform
  final int _barsCount = 48;
  List<double> _currentAmplitudes = [];
  List<double>? _finalAmplitudes;
  Timer? _waveformTimer;
  final Random _rng = Random();

  // Label style
  final TextStyle _labelStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: HexColor('#333333'),
  );

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _currentAmplitudes = List<double>.filled(_barsCount, 0.08);
    _initRecorder();
  }

  Future<void> _initRecorder() async {
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException("Permission microphone refusée");
    }
    await _recorder.openRecorder();
    await _recorder.setSubscriptionDuration(const Duration(milliseconds: 50));
    await _player.openPlayer();
    setState(() {
      _isRecorderInitialized = true;
    });
  }

  @override
  void dispose() {
    _waveformTimer?.cancel();
    _tabController.dispose();
    _recorder.closeRecorder();
    _player.closePlayer();
    super.dispose();
  }

  Future<void> _toggleRecording() async {
    if (!_isRecorderInitialized) return;

    if (_isRecording) {
      final path = await _recorder.stopRecorder();
      _waveformTimer?.cancel();
      setState(() {
        _isRecording = false;
        _audioPath = path;
        _finalAmplitudes = List<double>.from(_currentAmplitudes);
      });
    } else {
      final fileName = 'compte_rendu_${DateTime.now().millisecondsSinceEpoch}.aac';
      await _recorder.startRecorder(toFile: fileName, codec: Codec.aacADTS);

      _waveformTimer?.cancel();
      _waveformTimer = Timer.periodic(const Duration(milliseconds: 60), (_) {
        setState(() {
          for (int i = 0; i < _barsCount; i++) {
            _currentAmplitudes[i] = 0.05 + _rng.nextDouble() * 0.95;
          }
        });
      });

      setState(() {
        _isRecording = true;
        _audioPath = null;
        _finalAmplitudes = null;
      });
    }
  }

  Future<void> _togglePlay() async {
    if (_audioPath == null) return;

    if (_isPlaying) {
      await _player.stopPlayer();
      setState(() => _isPlaying = false);
    } else {
      await _player.startPlayer(
        fromURI: _audioPath!,
        whenFinished: () => setState(() => _isPlaying = false),
      );
      setState(() => _isPlaying = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.65,
        minChildSize: 0.45,
        maxChildSize: 0.95,
        builder: (context, scrollController) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 5,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: HexColor('#CBD5E1'),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Ajouter un compte rendu",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                          color: HexColor('#231F20')),
                    ),
                    InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(Icons.close, size: 24),
                    )
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    final titles = ["Texte", "Audio", "Vidéo"];
                    final isSelected = _tabController.index == index;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: ChoiceChip(
                        label: Text(titles[index]),
                        selected: isSelected,
                        onSelected: (_) =>
                            setState(() => _tabController.index = index),
                        selectedColor: HexColor('#B53C3A'),
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : HexColor('#305579'),
                          fontWeight: FontWeight.w600,
                        ),
                        backgroundColor: HexColor('#F4F6F9'),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 6),
                        avatar: null, // <-- supprime le check
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _buildTexteTab(scrollController),
                      _buildAudioTab(scrollController),
                      _buildVideoTab(scrollController),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                _buildFixedButtons(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTexteTab(ScrollController controller) {
    return SingleChildScrollView(
      controller: controller,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCategoryDropdown(),
          Text("Titre du compte rendu", style: _labelStyle),
          const SizedBox(height: 4),
          _buildTextField(_titreController, "Saisir", height: 50),
          const SizedBox(height: 12),
          Text("Texte", style: _labelStyle),
          const SizedBox(height: 4),
          _buildTextField(_texteController, "Saisir", maxLines: 3, height: 60),
        ],
      ),
    );
  }

  Widget _buildAudioTab(ScrollController controller) {
    final amplitudesToShow = _finalAmplitudes ?? _currentAmplitudes;

    return SingleChildScrollView(
      controller: controller,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCategoryDropdown(),
          Text("Titre du compte rendu", style: _labelStyle),
          const SizedBox(height: 4),
          _buildTextField(_audioTitreController, "Saisir", height: 50),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: HexColor('#CBD5E1')),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 60,
                    child: CustomPaint(
                        painter: WaveformPainter(amplitudes: amplitudesToShow)),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  iconSize: 32,
                  icon: Icon(
                    _isRecording ? Icons.stop_circle : Icons.mic,
                    color: _isRecording
                        ? HexColor('#B53C3A')
                        : HexColor('#285D90'),
                  ),
                  onPressed: _toggleRecording,
                ),
              ],
            ),
          ),
          if (_audioPath != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: OutlinedButton.icon(
                onPressed: _togglePlay,
                icon: Icon(_isPlaying ? Icons.stop : Icons.play_arrow,
                    color: HexColor('#285D90')),
                label: Text(_isPlaying ? "Stop" : "Écouter",
                    style: TextStyle(color: HexColor('#285D90'))),
                style: OutlinedButton.styleFrom(
                    side: BorderSide(color: HexColor('#285D90'))),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildVideoTab(ScrollController controller) {
    return SingleChildScrollView(
      controller: controller,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCategoryDropdown(),
          Text("Titre du compte rendu", style: _labelStyle),
          const SizedBox(height: 4),
          _buildTextField(_videoTitreController, "Saisir", height: 50),
          const SizedBox(height: 12),
          Container(
            height: 160,
            decoration: BoxDecoration(
              border: Border.all(color: HexColor('#CBD5E1')),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/icons/Cinema.png', width: 50, height: 50),
                  const SizedBox(height: 6),
                  Text("Sélectionnez une vidéo de votre galerie",
                      style: TextStyle(fontSize: 14)),
                  const SizedBox(height: 8),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                        side: BorderSide(color: HexColor('#4A739C')),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    child: const Text("Choisir une vidéo"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFixedButtons() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: HexColor('#285D90'),
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: Text("Enregistrer",
                style: TextStyle(fontSize: 15, color: HexColor('#FFFFFF'))),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: Image.asset('assets/icons/send.png'),
            label: Text("Partager la fiche avec un médecin",
                style: TextStyle(color: HexColor('#B53C3A'))),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: HexColor('#DADADA')),
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Catégorie", style: _labelStyle),
        const SizedBox(height: 4),
        DropdownButtonFormField<String>(
          value: _selectedCategory,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
          ),
          hint: Text("Sélectionner"),
          items: _categories
              .map((c) => DropdownMenuItem(value: c, child: Text(c)))
              .toList(),
          onChanged: (val) => setState(() => _selectedCategory = val),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText,
      {int maxLines = 1, double height = 40}) {
    return SizedBox(
      height: maxLines == 1 ? height : null,
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}

// Waveform painter
class WaveformPainter extends CustomPainter {
  final List<double> amplitudes;
  final Color barColor;
  WaveformPainter({required this.amplitudes, this.barColor = const Color(0xFF285D90)});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = barColor;
    final int count = amplitudes.length;
    if (count == 0) return;

    final double barSpacing = size.width / count;
    final double barWidth = barSpacing * 0.65;

    for (int i = 0; i < count; i++) {
      final double amp = amplitudes[i].clamp(0.0, 1.0);
      final double barHeight = amp * size.height;
      final double x = i * barSpacing + (barSpacing - barWidth) / 2;
      final double y = (size.height - barHeight) / 2;
      final rect = Rect.fromLTWH(x, y, barWidth, barHeight);
      final rrect = RRect.fromRectAndRadius(rect, Radius.circular(barWidth * 0.2));
      canvas.drawRRect(rrect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant WaveformPainter oldDelegate) {
    return oldDelegate.amplitudes != amplitudes || oldDelegate.barColor != barColor;
  }
}
