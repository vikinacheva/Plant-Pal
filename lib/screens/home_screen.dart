import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    _MyPlantsScreen(),
    _WateringPlanScreen(),
    _SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF2A2A26),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.local_florist),
            label: 'My Plants',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Watering Plan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

// ========== Individual Screen Widgets ==========

class _MyPlantsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Plants'),
        backgroundColor: const Color(0xFF2A2A26),
      ),
      body: const Center(
        child: Text('No plants added yet.'),
      ),
    );
  }
}

class _WateringPlanScreen extends StatelessWidget {
  String _currentMonth() {
    final now = DateTime.now();
    return "${now.month.toString().padLeft(2, '0')}/${now.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watering Plan – ${_currentMonth()}'),
        backgroundColor: const Color(0xFF2A2A26),
      ),
      body: const Center(
        child: Text('No scheduled tasks for this month.'),
      ),
    );
  }
}

class _SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: const Color(0xFF2A2A26),
      ),
      body: ListView(
        children: const [
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifications'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Log Out'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }
}
