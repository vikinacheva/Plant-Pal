import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlantTypeScreen extends StatefulWidget {
  final void Function(String plantType) onNext;
  const PlantTypeScreen({required this.onNext, Key? key}) : super(key: key);

  @override
  State<PlantTypeScreen> createState() => _PlantTypeScreenState();
}

class _PlantTypeScreenState extends State<PlantTypeScreen> {
  String? _selectedType;
  final List<String> _plantTypes = ['Succulents', 'Herbs', 'Flowers', 'Tropical', 'Cacti', 'Other'];

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
                  // Welcome label
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A2A26),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text(
                        'Let\'s find your plant type',
                        style: GoogleFonts.lobster(
                          color: Colors.white,
                          fontSize: 28,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Question
                  Text(
                    'What kind of plants do you have?',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF2A2A26),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Plant type options
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    alignment: WrapAlignment.center,
                    children: _plantTypes.map((type) {
                      final bool isSelected = _selectedType == type;
                      return ChoiceChip(
                        label: Text(type, style: GoogleFonts.poppins(color: isSelected ? Colors.white : Colors.black)),
                        selected: isSelected,
                        onSelected: (_) {
                          setState(() => _selectedType = type);
                        },
                        selectedColor: const Color(0xFF2A2A26),
                        backgroundColor: Colors.grey[200],
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 40),

                  // Next button
                  Center(
                    child: SizedBox(
                      width: 140,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: _selectedType == null
                            ? null
                            : () => widget.onNext(_selectedType!),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2A2A26),
                          elevation: 8,
                          shadowColor: const Color(0xFF2A2A26).withOpacity(0.6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Next',
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
