import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CareFrequencyScreen extends StatefulWidget {
  final void Function(int) onNext;
  const CareFrequencyScreen({required this.onNext, Key? key}) : super(key: key);

  @override
  State<CareFrequencyScreen> createState() => _CareFrequencyScreenState();
}

class _CareFrequencyScreenState extends State<CareFrequencyScreen> {
  double _slider = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/questionnaire_bg.jpg', fit: BoxFit.cover),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 120, left: 32, right: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A2A26),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text(
                        'Let\'s see your plant care routine',
                        style: GoogleFonts.lobster(
                          color: Colors.white,
                          fontSize: 28,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'How often do you water your plants per month?',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF2A2A26),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    '${_slider.round()} times/month',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF2A2A26),
                    ),
                  ),
                  Slider(
                    min: 0,
                    max: 30,
                    divisions: 30,
                    value: _slider,
                    activeColor: const Color(0xFF2A2A26),
                    onChanged: (v) => setState(() => _slider = v),
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: SizedBox(
                      width: 140,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () async {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setInt('careFrequency', _slider.round());
                          await prefs.setBool('onboardingComplete', true);

                          Navigator.pushReplacementNamed(context, '/home');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2A2A26),
                          elevation: 8,
                          shadowColor: const Color(0xFF2A2A26).withOpacity(0.6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Finish',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
