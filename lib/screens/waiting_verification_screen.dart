import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WaitingForVerificationScreen extends StatefulWidget {
  @override
  _WaitingForVerificationScreenState createState() => _WaitingForVerificationScreenState();
}

class _WaitingForVerificationScreenState extends State<WaitingForVerificationScreen> {
  Timer? _timer;
  bool _checking = true;

  @override
  void initState() {
    super.initState();
    _startChecking();
  }

  void _startChecking() {
    _timer = Timer.periodic(Duration(seconds: 5), (_) async {
      final user = FirebaseAuth.instance.currentUser;
      await user?.reload();
      if (user != null && user.emailVerified) {
        _timer?.cancel();
        Navigator.pushReplacementNamed(context, '/onboarding');
      }
      setState(() => _checking = false);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.mark_email_read_outlined, size: 72, color: Colors.green),
              SizedBox(height: 24),
              Text(
                "We've sent you a verification email.",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12),
              Text(
                "Please check your inbox and verify your email address. We'll automatically continue once you're verified.",
                textAlign: TextAlign.center,
              ),
              if (_checking)
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
