import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/login_bottom_sheet.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _showLogin = false;

  void _revealLogin() {
    setState(() => _showLogin = true);
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Hero image
          AnimatedPositioned(
            duration: Duration(milliseconds: 600),
            curve: Curves.easeOut,
            top: _showLogin ? screenHeight * 0.08 : screenHeight * 0.2,
            left: 0,
            right: 0,
            child: Center(
              child: AnimatedContainer(
                duration: Duration(milliseconds: 600),
                curve: Curves.easeOut,
                height: screenHeight * 0.35,
                child: Image.asset('assets/images/strelitzia.png'),
              ),
            ),
          ),

          // Welcome text & Get Started button
          if (!_showLogin)
            Positioned(
              top: screenHeight * 0.62,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Text(
                    "Let your plants thrive,\none drop at a time.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF505021),
                    ),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: _revealLogin,
                    style: _customButtonStyle(),
                    child: Text(
                      "Get Started",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // Login / Signup Bottom Sheet
          AnimatedPositioned(
            duration: Duration(milliseconds: 700),
            curve: Curves.easeOut,
            bottom: _showLogin ? 0 : -screenHeight * 0.6,
            left: 0,
            right: 0,
            child: LoginBottomSheet(), // Make sure signup navigates to OnboardingScreen!
          ),
        ],
      ),
    );
  }

  ButtonStyle _customButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF17261F),
      foregroundColor: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 6,
      shadowColor: Colors.green.withOpacity(0.4),
    );
  }
}
