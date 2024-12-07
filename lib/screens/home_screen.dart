import 'package:flutter/material.dart';
import 'package:healix/widgets/service_icon.dart';
import 'package:healix/widgets/appointment_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<Map<String, String>> offers = [
    {'title': '20% Off on Consultation', 'details': 'Use code SAVE20', 'color': 'teal'},
    {'title': 'Free Blood Test', 'details': 'Get your blood test free today', 'color': 'orange'},
    {'title': 'Buy 1 Get 1 Free Medicine', 'details': 'Limited time offer', 'color': 'purple'},
  ];

  final List<Map<String, String>> appointments = [
    {'day': "12", 'weekday': "Tue", 'doctor': "Dr. Samuel", 'specialty': "Depression", 'color': 'teal', 'icon': Icons.emoji_emotions.codePoint.toString()},
    {'day': "13", 'weekday': "Wed", 'doctor': "Dr. Lisa", 'specialty': "Dermatology", 'color': 'orange', 'icon': Icons.face.codePoint.toString()},
    {'day': "14", 'weekday': "Thu", 'doctor': "Dr. Mark", 'specialty': "Pediatrics", 'color': 'purple', 'icon': Icons.child_care.codePoint.toString()},
    {'day': "15", 'weekday': "Fri", 'doctor': "Dr. Jane", 'specialty': "Cardiology", 'color': 'red', 'icon': Icons.favorite.codePoint.toString()},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Box
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _searchController,
                  onChanged: (query) {
                    setState(() {
                      _searchQuery = query.toLowerCase();
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search medical...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Services Section
              Text(
                'Services',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              SizedBox(height: 16),
              GridView.count(
                crossAxisCount: 4,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  ServiceIcon(icon: Icons.people, title: "Doctors", color: Colors.blue),
                  ServiceIcon(icon: Icons.local_hospital, title: "Pharmacy", color: Colors.orange),
                  ServiceIcon(icon: Icons.health_and_safety, title: "Health Tips", color: Colors.green),
                  ServiceIcon(icon: Icons.emergency_outlined, title: "Emergency", color: Colors.red),
                ],
              ),
              SizedBox(height: 20),
 Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.teal.shade300, Colors.teal.shade600],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Get the Best\nmedical Services',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            'We provide quality medical\nservices without further cost.',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.medical_services,
                      color: Colors.white,
                      size: 80,
                    ),
                  ],
                ),
              ),
              // Explore Offers Section
              _buildSectionHeader(
                title: 'Explore Offers',
                onViewAllPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OffersPage()),
                  );
                },
              ),
              SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: offers
                      .where((offer) => _searchQuery.isEmpty || offer['title']!.toLowerCase().contains(_searchQuery))
                      .map((offer) {
                    return _buildOfferCard(
                      title: offer['title']!,
                      details: offer['details']!,
                      color: getColorFromString(offer['color']!),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 20),

              // Upcoming Appointments Section
              _buildSectionHeader(
                title: 'Upcoming Appointments',
                onViewAllPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AppointmentsPage()),
                  );
                },
              ),
              SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: appointments
                      .where((appointment) => _searchQuery.isEmpty || appointment['doctor']!.toLowerCase().contains(_searchQuery))
                      .map((appointment) {
                    return _buildAppointmentCard(
                      day: appointment['day']!,
                      weekday: appointment['weekday']!,
                      doctor: appointment['doctor']!,
                      specialty: appointment['specialty']!,
                      color: getColorFromString(appointment['color']!),
                      icon: IconData(int.parse(appointment['icon']!), fontFamily: 'MaterialIcons'),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper to build a section header with a title and "View All" button
  Widget _buildSectionHeader({required String title, required VoidCallback onViewAllPressed}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        TextButton(
          onPressed: onViewAllPressed,
          child: Text(
            'View All',
            style: TextStyle(color: Colors.teal),
          ),
        ),
      ],
    );
  }

  // Helper to build an offer card
  Widget _buildOfferCard({required String title, required String details, required Color color}) {
    return Container(
      width: 200,
      margin: EdgeInsets.only(right: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 8),
          Text(
            details,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  // Helper to build an appointment card styled like an offer card
  Widget _buildAppointmentCard({
    required String day,
    required String weekday,
    required String doctor,
    required String specialty,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      width: 200,
      margin: EdgeInsets.only(right: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 30,
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    weekday,
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  Text(
                    day,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            doctor,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 8),
          Text(
            specialty,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  // Helper to get a color from a string
  Color getColorFromString(String colorName) {
    switch (colorName) {
      case 'teal':
        return Colors.teal;
      case 'orange':
        return Colors.orange;
      case 'purple':
        return Colors.purple;
      case 'red':
        return Colors.red;
      default:
        return Colors.blue;
    }
  }
}

// Offers Page
class OffersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('All Offers')),
      body: Center(child: Text('All Offers Page')),
    );
  }
}

// Appointments Page
class AppointmentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('All Appointments')),
      body: Center(child: Text('All Appointments Page')),
    );
  }
}
