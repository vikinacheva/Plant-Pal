import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'name_screen.dart';
import 'plant_type_screen.dart';
import 'care_frequency_screen.dart';
import 'package:dots_indicator/dots_indicator.dart';

class OnboardingFlow extends StatefulWidget {
  @override
  _OnboardingFlowState createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  final _pageController = PageController();
  int _currentIndex = 0;
  String? userName, plantType;
  int? careFrequency;

  void _nextName(String name) {
    userName = name;
    _pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeOut);
  }
  void _nextPlantType(String type) {
    plantType = type;
    _pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeOut);
  }
  Future<void> _finish(int frequency) async {
    careFrequency = frequency;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboardingComplete', true);
    await prefs.setString('userName', userName!);
    await prefs.setString('plantType', plantType!);
    await prefs.setInt('careFrequency', careFrequency!);

    final uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'name': userName,
      'plantType': plantType,
      'careFrequency': careFrequency,
      'uid': uid,
      'email': FirebaseAuth.instance.currentUser!.email,
    });

    Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (i) => setState(() => _currentIndex = i),
              children: [
                NameScreen(onNext: _nextName),
                PlantTypeScreen(onNext: _nextPlantType),
                CareFrequencyScreen(onNext: _finish),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: DotsIndicator(
              dotsCount: 3,
              position: _currentIndex.toDouble(),
              decorator: DotsDecorator(
                activeColor: Color(0xFF2A2A26),
                color: Colors.grey[400]!,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
