import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'welcome_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _displayName;

  @override
  void initState() {
    super.initState();
    _loadDisplayName();
  }

  Future<void> _loadDisplayName() async {
    final prefs = await SharedPreferences.getInstance();
    final userName = prefs.getString('userName');
    final firebaseName = FirebaseAuth.instance.currentUser?.displayName;

    setState(() {
      _displayName = userName ?? firebaseName ?? 'Plant Lover';
    });
  }

  void _signOut(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // clear local storage
    await FirebaseAuth.instance.signOut(); // sign out from Firebase

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => WelcomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, ${_displayName ?? '...'}'),
        backgroundColor: Colors.green[700],
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _signOut(context),
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Your plants are in good hands! 🌱',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
