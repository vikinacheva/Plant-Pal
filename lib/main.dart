import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/welcome_screen.dart';
import 'screens/home_screen.dart';
import 'screens/onboarding_flow.dart';
import 'screens/waiting_verification_screen.dart';
import 'constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(PlantPalApp());
}

class PlantPalApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PlantPal',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: kPrimaryColor,
          secondary: kPrimaryColor,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryColor,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      home: AuthGate(),
      routes: {
        '/home': (context) => HomeScreen(),
        '/onboarding': (context) => OnboardingFlow(),
        '/welcome': (context) => WelcomeScreen(),
        '/waiting_verification': (context) => WaitingForVerificationScreen(),
      },
    );
  }
}

class AuthGate extends StatefulWidget {
  @override
  _AuthGateState createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  bool? onboardingComplete;
  bool checkingVerification = true;

  @override
  void initState() {
    super.initState();
    _initializeState();
  }

  Future<void> _initializeState() async {
    final prefs = await SharedPreferences.getInstance();
    final onboardingDone = prefs.getBool('onboardingComplete') ?? false;

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.reload(); // Refresh verification state
    }

    setState(() {
      onboardingComplete = onboardingDone;
      checkingVerification = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (onboardingComplete == null || checkingVerification) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        final user = snapshot.data;

        if (user != null && user.emailVerified) {
          return onboardingComplete == true
              ? HomeScreen()
              : OnboardingFlow();
        }

        return WelcomeScreen();
      },
    );
  }
}
