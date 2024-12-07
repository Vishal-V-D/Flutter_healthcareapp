import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medcoins App',
      theme: ThemeData.light(),
      home: MedcoinsScreen(),
    );
  }
}

class MedcoinsScreen extends StatefulWidget {
  @override
  _MedcoinsScreenState createState() => _MedcoinsScreenState();
}

class _MedcoinsScreenState extends State<MedcoinsScreen> {
  int totalCoins = 500; // User's total coins
  List<Map<String, dynamic>> tasks = [
    {"task": "Complete your health survey", "coins": 50},
    {"task": "Refer a friend to the app", "coins": 100},
    {"task": "Upload a prescription", "coins": 75},
  ]; // Tasks to earn coins

  void _completeTask(int coinsEarned) {
    setState(() {
      totalCoins += coinsEarned;
    });
  }

  void _redeemCoins() {
    // Placeholder for redeem functionality
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Redeem Coins'),
          content: Text('You can redeem coins for discounts on medicines.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _spinWheel() {
    final randomCoins = (50 + (100 * (0.5 + 0.5)).toInt()); // Simulated spin result
    setState(() {
      totalCoins += randomCoins;
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("You earned $randomCoins coins!"),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medcoins'),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Total Coins
              Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.monetization_on,
                      color: Colors.amber, // Gold color for coins
                      size: 50,
                    ),
                    Text(
                      '$totalCoins Coins',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Tasks Section
              Text(
                "Complete Tasks to Earn Coins",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurple),
              ),
              SizedBox(height: 10),
              ...tasks.map((task) {
                return Card(
                  elevation: 4,
                  color: Colors.blue.shade50,
                  child: ListTile(
                    title: Text(
                      task["task"],
                      style: TextStyle(color: Colors.deepPurple),
                    ),
                    trailing: ElevatedButton(
                      onPressed: () {
                        _completeTask(task["coins"]);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrangeAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        "+${task["coins"]} Coins",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              }).toList(),
              SizedBox(height: 20),

              // Redeem Section
              Center(
                child: ElevatedButton.icon(
                  onPressed: _redeemCoins,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  icon: Icon(Icons.redeem, color: Colors.white),
                  label: Text(
                    "Redeem Coins",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Fun Section to Earn More Coins
              Text(
                "Play Games to Earn Coins",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
              ),
              SizedBox(height: 10),

              // Spin Wheel Section
              Card(
                elevation: 6,
                color: Colors.green.shade50,
                child: ListTile(
                  leading: Icon(Icons.casino, size: 40, color: Colors.green),
                  title: Text(
                    "Spin the Wheel",
                    style: TextStyle(fontSize: 16, color: Colors.green),
                  ),
                  subtitle: Text("Try your luck and win coins!"),
                  trailing: ElevatedButton(
                    onPressed: _spinWheel,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text("Spin"),
                  ),
                ),
              ),

              // Placeholder for more games
              Card(
                elevation: 6,
                color: Colors.pink.shade50,
                child: ListTile(
                  leading: Icon(Icons.videogame_asset, size: 40, color: Colors.pink),
                  title: Text(
                    "More Games Coming Soon!",
                    style: TextStyle(fontSize: 16, color: Colors.pink),
                  ),
                  subtitle: Text("Stay tuned for exciting games."),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
