import 'package:flutter/material.dart';

void main() {
  runApp(AppointmentApp());
}

class AppointmentApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: Colors.blue.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: Colors.blue),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: Colors.blue.shade200),
          ),
        ),
      ),
      home: DoctorAppointmentPage(),
    );
  }
}

class DoctorAppointmentPage extends StatefulWidget {
  @override
  _DoctorAppointmentPageState createState() => _DoctorAppointmentPageState();
}

class _DoctorAppointmentPageState extends State<DoctorAppointmentPage> {
  final _formKey = GlobalKey<FormState>();

  // Form data variables
  String? _selectedDoctor;
  String? _selectedVenue;
  String? _selectedHospital;
  DateTime? _selectedDate;
  String _patientName = '';
  String _patientContact = '';
  String _paymentMethod = '';
  String? _selectedTimeSlot;
  String? _selectedSpecialistIssue;
  String? _appointmentMode;
  String _additionalDetails = '';

  // Dummy data for doctors, hospitals, and venues
  final List<Map<String, String>> _doctors = [
    {'name': 'Dr. Sarah', 'image': 'https://randomuser.me/api/portraits/women/44.jpg'},
    {'name': 'Dr. Mike', 'image': 'https://randomuser.me/api/portraits/men/46.jpg'},
    {'name': 'Dr. Emma', 'image': 'https://randomuser.me/api/portraits/women/47.jpg'},
    {'name': 'Dr. James', 'image': 'https://randomuser.me/api/portraits/men/48.jpg'},
    {'name': 'Dr. Anna', 'image': 'https://randomuser.me/api/portraits/women/49.jpg'},
  ];
  final List<String> _venues = ['City Hospital', 'Health Clinic', 'Downtown Office'];
  final List<String> _hospitals = ['City Hospital', 'Greenwood Medical Center', 'Westside Clinic'];
  final List<String> _timeSlots = ['9:00 AM', '10:00 AM', '11:00 AM', '1:00 PM', '3:00 PM'];
  final List<String> _specialistIssues = ['Cardiology', 'Neurology', 'Orthopedics', 'Pediatrics'];
  final List<String> _appointmentModes = ['In-person', 'Online', 'Hybrid'];

  // Function to pick a date
  Future<void> _pickDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  // Function to submit the form
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'Appointment Confirmation',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Appointment successfully booked!',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text('Doctor: $_selectedDoctor'),
              Text('Date: ${_selectedDate?.toLocal().toString().split(' ')[0]}'),
              Text('Time: $_selectedTimeSlot'),
              Text('Venue: $_selectedVenue'),
              Text('Hospital: $_selectedHospital'),
              Text('Mode: $_appointmentMode'),
              Text('Specialist Issue: $_selectedSpecialistIssue'),
              Text('Patient: $_patientName'),
              Text('Contact: $_patientContact'),
              Text('Payment: $_paymentMethod'),
              SizedBox(height: 10),
              if (_additionalDetails.isNotEmpty) Text('Additional Details: $_additionalDetails'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Doctor selection with images
              Text(
                'Select a Doctor',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Container(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _doctors.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedDoctor = _doctors[index]['name'];
                        });
                      },
                      child: Card(
                        color: _selectedDoctor == _doctors[index]['name']
                            ? Colors.blue.shade100
                            : Colors.white,
                        elevation: 3,
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundImage: NetworkImage(
                                  _doctors[index]['image']!,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                _doctors[index]['name']!,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 16),

              // Date selection
              Text(
                'Select a Date',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedDate == null
                        ? 'No date selected'
                        : 'Selected Date: ${_selectedDate?.toLocal().toString().split(' ')[0]}',
                  ),
                  ElevatedButton(
                    onPressed: () => _pickDate(context),
                    child: Text('Pick Date'),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Time slot selection
              Text(
                'Select a Time Slot',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Time Slot',
                ),
                items: _timeSlots
                    .map((slot) => DropdownMenuItem(
                          value: slot,
                          child: Text(slot),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedTimeSlot = value;
                  });
                },
                validator: (value) => value == null ? 'Please select a time slot' : null,
              ),
              SizedBox(height: 16),

              // Specialist Issue selection
              Text(
                'Select Specialist Issue',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Specialist Issue',
                ),
                items: _specialistIssues
                    .map((issue) => DropdownMenuItem(
                          value: issue,
                          child: Text(issue),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedSpecialistIssue = value;
                  });
                },
                validator: (value) => value == null ? 'Please select an issue' : null,
              ),
              SizedBox(height: 16),

              // Appointment Mode selection
              Text(
                'Select Appointment Mode',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Appointment Mode',
                ),
                items: _appointmentModes
                    .map((mode) => DropdownMenuItem(
                          value: mode,
                          child: Text(mode),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _appointmentMode = value;
                  });
                },
                validator: (value) => value == null ? 'Please select an appointment mode' : null,
              ),
              SizedBox(height: 16),

              // Venue selection
              Text(
                'Select a Venue',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Venue',
                ),
                items: _venues
                    .map((venue) => DropdownMenuItem(
                          value: venue,
                          child: Text(venue),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedVenue = value;
                  });
                },
                validator: (value) => value == null ? 'Please select a venue' : null,
              ),
              SizedBox(height: 16),

              // Hospital selection
              Text(
                'Select a Hospital',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Hospital',
                ),
                items: _hospitals
                    .map((hospital) => DropdownMenuItem(
                          value: hospital,
                          child: Text(hospital),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedHospital = value;
                  });
                },
                validator: (value) => value == null ? 'Please select a hospital' : null,
              ),
              SizedBox(height: 16),

              // Patient information
              Text(
                'Patient Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Patient Name',
                ),
                onSaved: (value) {
                  _patientName = value!;
                },
                validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter your name' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Patient Contact',
                ),
                keyboardType: TextInputType.phone,
                onSaved: (value) {
                  _patientContact = value!;
                },
                validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter your contact' : null,
              ),
              SizedBox(height: 16),

              // Additional Details
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Additional Details (optional)',
                ),
                onSaved: (value) {
                  _additionalDetails = value!;
                },
              ),
              SizedBox(height: 16),

              // Payment method
              Text(
                'Payment Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Payment Method (e.g., Credit Card, Cash)',
                ),
                onSaved: (value) {
                  _paymentMethod = value!;
                },
                validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter payment method' : null,
              ),
              SizedBox(height: 32),

              // Submit button
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Confirm Appointment'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  textStyle: TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
