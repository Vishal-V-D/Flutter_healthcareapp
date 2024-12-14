import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  // Example data for previous chats, orders, and appointments
  final List<Map<String, String>> previousChats = [
    {"date": "2024-12-05", "message": "What is diabetes?"},
    {"date": "2024-12-04", "message": "What are flu symptoms?"},
    {"date": "2024-12-03", "message": "How to manage high blood pressure?"},
  ];

  final List<Map<String, String>> orderedMedicines = [
    {"date": "2024-12-01", "medicine": "Paracetamol", "status": "Delivered"},
    {"date": "2024-11-28", "medicine": "Cough Syrup", "status": "In Transit"},
    {"date": "2024-11-20", "medicine": "Ibuprofen", "status": "Delivered"},
  ];

  final List<Map<String, String>> medicalAppointments = [
    {"date": "2024-11-30", "doctor": "Dr. John Doe", "status": "Completed"},
    {"date": "2024-11-25", "doctor": "Dr. Sarah Smith", "status": "Cancelled"},
    {"date": "2024-11-15", "doctor": "Dr. Emily Clark", "status": "Completed"},
  ];

  bool showChatHistory = true; // Toggle for chat history visibility

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        backgroundColor: Colors.teal, // Change AppBar color to teal
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(  // Make the body scrollable to prevent overflow
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Toggle for Chat History Visibility
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Chat History",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
                Switch(
                  value: showChatHistory,
                  onChanged: (value) {
                    setState(() {
                      showChatHistory = value;
                    });
                  },
                  activeColor: Colors.purple, // Change toggle color to purple
                  inactiveThumbColor: Colors.grey,
                ),
              ],
            ),
            SizedBox(height: 10),

            // Previous Chats Section (only if toggle is on)
            if (showChatHistory)
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                margin: EdgeInsets.only(bottom: 16),
                child: ExpansionTile(
                  leading: Icon(Icons.chat, color: Colors.blue),
                  title: Text(
                    "Previous Chats",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  children: previousChats.map((chat) {
                    return ListTile(
                      leading: Icon(Icons.message, color: Colors.grey),
                      title: Text(chat["message"]!),
                      subtitle: Text("Date: ${chat["date"]}"),
                    );
                  }).toList(),
                ),
              ),

            // Ordered Medicines Section
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              margin: EdgeInsets.only(bottom: 16),
              child: ExpansionTile(
                leading: Icon(Icons.local_pharmacy, color: Colors.green),
                title: Text(
                  "Ordered Medicines",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                children: orderedMedicines.map((order) {
                  return ListTile(
                    leading: Icon(
                      Icons.medical_services,
                      color: order["status"] == "Delivered" ? Colors.green : Colors.orange,
                    ),
                    title: Text(order["medicine"]!),
                    subtitle: Text("Date: ${order["date"]}\nStatus: ${order["status"]}"),
                  );
                }).toList(),
              ),
            ),

            // Medical Appointments Section
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              margin: EdgeInsets.only(bottom: 16),
              child: ExpansionTile(
                leading: Icon(Icons.calendar_today, color: Colors.red),
                title: Text(
                  "Medical Appointments",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                children: medicalAppointments.map((appointment) {
                  return ListTile(
                    leading: Icon(
                      Icons.person,
                      color: appointment["status"] == "Completed" ? Colors.green : Colors.red,
                    ),
                    title: Text("Doctor: ${appointment["doctor"]}"),
                    subtitle: Text("Date: ${appointment["date"]}\nStatus: ${appointment["status"]}"),
                  );
                }).toList(),
              ),
            ),

            // Memory Section
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              margin: EdgeInsets.only(bottom: 16),
              child: ExpansionTile(
                leading: Icon(Icons.memory, color: Colors.purple),
                title: Text(
                  "Memory",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                children: [
                  ListTile(
                    title: Text("Your Favorite Medicine: Paracetamol"),
                    subtitle: Text("Stored for quick access."),
                  ),
                  ListTile(
                    title: Text("Most Frequent Appointment: Dr. John Doe"),
                    subtitle: Text("You visit frequently."),
                  ),
                ],
              ),
            ),

            // Notifications Section
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              margin: EdgeInsets.only(bottom: 16),
              child: ExpansionTile(
                leading: Icon(Icons.notifications, color: Colors.orange),
                title: Text(
                  "Notifications",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                children: [
                  ListTile(
                    title: Text("New Medicine Offer: 20% off on Paracetamol"),
                    subtitle: Text("Valid till 2024-12-10."),
                  ),
                  ListTile(
                    title: Text("Appointment Reminder: Dr. John Doe tomorrow"),
                    subtitle: Text("Don't forget your checkup!"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
