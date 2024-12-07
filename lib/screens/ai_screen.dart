import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Chatbot',
      theme: ThemeData.light(),
      home: ChatBotScreen(),
    );
  }
}

class ChatBotScreen extends StatefulWidget {
  @override
  _ChatBotScreenState createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, String>> _messages = [];

  // Predefined responses for quick buttons
  final Map<String, String> predefinedMessages = {
     "What is diabetes?":
        "Diabetes is a chronic health condition that affects how your body turns food into energy.",
    "What are flu symptoms?":
        "Flu symptoms include fever, chills, muscle aches, cough, congestion, runny nose, and fatigue.",
    "How to manage high blood pressure?":
        "Managing high blood pressure includes a healthy diet, regular exercise, stress management, and medication if prescribed.",
    "What is a healthy BMI?":
        "A healthy BMI ranges between 18.5 and 24.9. Maintaining this range helps reduce the risk of various diseases.",
    "What is a balanced diet?":
        "A balanced diet includes fruits, vegetables, whole grains, lean proteins, and healthy fats while limiting processed foods and sugar.",
    "What is a heart attack?":
        "A heart attack occurs when blood flow to the heart is blocked. Symptoms include chest pain, shortness of breath, and nausea.",
    "What is COVID-19?":
        "COVID-19 is an infectious disease caused by the SARS-CoV-2 virus, characterized by fever, cough, and difficulty breathing.",
    "How to improve mental health?":
        "Improving mental health includes regular exercise, connecting with loved ones, practicing mindfulness, and seeking professional help when needed.",
    "What are allergy symptoms?":
        "Allergy symptoms include sneezing, itchy eyes, runny nose, and sometimes skin rash or swelling.",
    "What are common cold remedies?":
        "Common cold remedies include staying hydrated, resting, and using over-the-counter cold medications or home remedies like ginger tea.",
  };

  void _sendMessage(String message) {
    setState(() {
      _messages.add({"sender": "user", "text": message});
      _messageController.clear();

      // Simulate a bot response with a small delay
      Future.delayed(Duration(milliseconds: 500), () {
        setState(() {
          _messages.add({"sender": "bot", "text": predefinedMessages[message] ?? "I'm here to help with your medical queries!"});
        });

        // Scroll to the bottom after the bot's response
        _scrollToBottom();
      });
    });

    // Scroll to the bottom after user's message
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Display only 3 predefined questions as buttons
    final visibleQuestions = predefinedMessages.keys.take(3).toList();
    final remainingQuestions = predefinedMessages.keys.skip(3).toList();

    return Scaffold(
      
      body: Column(
        children: [
          // Message Display Area
          Expanded(
            child: ListView.builder(
              controller: _scrollController, // Attach the scroll controller
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message["sender"] == "user";

                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: isUser
                            ? [Colors.teal, Colors.cyan]
                            : [Colors.white, Colors.purple.shade100],
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomLeft: isUser ? Radius.circular(15) : Radius.zero,
                        bottomRight: isUser ? Radius.zero : Radius.circular(15),
                      ),
                    ),
                    child: Text(
                      message["text"]!,
                      style: TextStyle(
                        fontSize: 16,
                        color: isUser ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Quick Replies (3 questions only)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 10,
              children: visibleQuestions.map((key) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal.shade200,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () => _sendMessage(key),
                  child: Text(key),
                );
              }).toList(),
            ),
          ),

          // Hint for more questions
          if (remainingQuestions.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "AI can make mistakes.Be cautious with the answers.!",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ),

          // Input Field with Microphone
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                // Microphone Icon
                IconButton(
                  icon: Icon(Icons.mic, color: Colors.teal),
                  onPressed: () {
                    // Simulate voice input - placeholder functionality
                    _sendMessage("Voice input detected...");
                  },
                ),
                SizedBox(width: 5),

                // Text Input Field
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: "Type your message...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                    ),
                  ),
                ),
                SizedBox(width: 10),

                // Send Button
                FloatingActionButton(
                  onPressed: () {
                    if (_messageController.text.trim().isNotEmpty) {
                      _sendMessage(_messageController.text.trim());
                    }
                  },
                  backgroundColor: Colors.teal,
                  child: Icon(Icons.send, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
