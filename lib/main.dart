import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/schedule_screen.dart';
import 'screens/report_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/bitcoin_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/history_screen.dart';
import 'screens/ai_screen.dart';
import 'screens/settings_screen.dart'; // Added the missing screen for settings

void main() {
  runApp(HealixApp());
}

class HealixApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Healix',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFF0F5F9),
        primarySwatch: Colors.teal,
        appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.teal.shade600,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Widget> _pages = [
    HomeScreen(),
    DoctorAppointmentPage(),
    AIScreen(),
    CommunityPage(),
    NotificationPage(),
    ProfileScreen(),
    HistoryScreen(),
  ];

  final List<String> _titles = [
    'Healix',
    'Schedule Appointments',
    'AI Assist',
    'Community',
    'Notifications',
    'Profile',
    'History',
  ];

  final int _coinAmount = 100; // Example coin amount

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        leading: GestureDetector(
          onTap: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 8, // Adjusted profile icon size to match Bitcoin icon size
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                color: Colors.teal,
                size: 24, // Adjusted to match Bitcoin icon size
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Row(
              children: [
                Icon(
                  Icons.currency_bitcoin,
                  color: Colors.amber, // Gold color for Bitcoin icon
                ),
                SizedBox(width: 4),
                Text(
                  '$_coinAmount', // Coin amount displayed next to the Bitcoin icon
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // White color for the coin amount
                  ),
                ),
              ],
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BitcoinScreen()),
              );
            },
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.teal.shade600,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Update the current index for navigation
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule_outlined),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_rounded),
            label: 'AI Assist',
            activeIcon: Icon(Icons.chat_rounded, color: _currentIndex == 2 ? Colors.cyan : Colors.grey), // Color change when selected
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outlined),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined),
            label: 'Notifications',
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.teal, Colors.teal.shade400],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 20,
                    child: Icon(
                      Icons.person,
                      color: Colors.teal,
                      size: 20,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Hello, User!',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Text(
                    'user@example.com',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                _navigateToScreen(ProfileScreen(), 'Profile');
              },
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text('History'),
              onTap: () {
                Navigator.pop(context);
                _navigateToScreen(HistoryScreen(), 'History');
              },
            ),
            ListTile(
              leading: Icon(Icons.chat_bubble_outline),
              title: Text('AI Assist'),
              onTap: () {
                setState(() {
                  _currentIndex = 2;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text('Community'),
              onTap: () {
                setState(() {
                  _currentIndex = 3;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Notifications'),
              onTap: () {
                setState(() {
                  _currentIndex = 4;
                });
                Navigator.pop(context);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(
                'Settings',
                style: TextStyle(color: Colors.teal.shade700), // Adjust color for visibility
              ),
              onTap: () {
                Navigator.pop(context);
                _navigateToScreen(SettingsScreen(), 'Settings');
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text('Help & Support'),
              onTap: () {
                // Handle Help & Support navigation
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                // Handle Logout functionality
              },
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToScreen(Widget screen, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }
}
