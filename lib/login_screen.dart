import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:healix/main_screen.dart';
 // Import your main screen here

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  bool isPasswordSecure = true;
  bool isConfirmPasswordSecure = true;
  bool isLoading = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final shakeAnim = ValueNotifier<double>(0);

  // Method to trigger shake animation on validation failure
  void shakeInput() {
    shakeAnim.value = 10;
    Future.delayed(Duration(milliseconds: 50), () {
      shakeAnim.value = -10;
    });
    Future.delayed(Duration(milliseconds: 100), () {
      shakeAnim.value = 0;
    });
  }

  // Show alert with error message
  void showAlert(String title, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("OK"),
          )
        ],
      ),
    );
  }

  // Handle login
  void handleLogin() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      showAlert('Error', 'Please enter both email and password.');
      shakeInput();
      return;
    }

    setState(() {
      isLoading = true;
    });

    // Simulate login process (replace with actual API call)
    await Future.delayed(Duration(seconds: 2));

    // Assuming login success
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MainScreen()),
    );

    setState(() {
      isLoading = false;
    });
  }

  // Handle sign-up
  void handleSignUp() async {
    if (usernameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneController.text.isEmpty ||
        passwordController.text.isEmpty ||
        passwordController.text != confirmPasswordController.text) {
      showAlert('Error', 'Please fill all fields and ensure passwords match.');
      shakeInput();
      return;
    }

    setState(() {
      isLoading = true;
    });

    // Simulate registration process (replace with actual API call)
    await Future.delayed(Duration(seconds: 2));

    // Assuming sign-up success
    showAlert('Success', 'Signup successful! Please log in.');
    setState(() {
      isLogin = true;
    });

    setState(() {
      isLoading = false;
    });
  }

  // Render login form
  Widget renderLogin() {
    return AnimatedBuilder(
      animation: shakeAnim,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(shakeAnim.value, 0),
          child: child,
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Login',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          buildTextField('Email', emailController, false),
          SizedBox(height: 16),
          buildTextField('Password', passwordController, true),
          SizedBox(height: 20),
          buildAuthButton('Login', handleLogin),
          TextButton(
            onPressed: () {
              setState(() {
                isLogin = false;
              });
            },
            child: Text("Don't have an account? Sign Up"),
          ),
        ],
      ),
    );
  }

  // Render sign-up form
  Widget renderSignUp() {
    return AnimatedBuilder(
      animation: shakeAnim,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(shakeAnim.value, 0),
          child: child,
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Sign Up',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          buildTextField('Username', usernameController, false),
          SizedBox(height: 16),
          buildTextField('Email', emailController, false),
          SizedBox(height: 16),
          buildTextField('Phone', phoneController, false),
          SizedBox(height: 16),
          buildTextField('Password', passwordController, true),
          SizedBox(height: 16),
          buildTextField('Confirm Password', confirmPasswordController, true),
          SizedBox(height: 20),
          buildAuthButton('Sign Up', handleSignUp),
          TextButton(
            onPressed: () {
              setState(() {
                isLogin = true;
              });
            },
            child: Text("Already have an account? Login"),
          ),
        ],
      ),
    );
  }

  // Common TextField builder with icon
  Widget buildTextField(String label, TextEditingController controller, bool isPassword) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Icon(Icons.email, color: Colors.teal),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: isPassword,
              decoration: InputDecoration(
                labelText: label,
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Auth button
  Widget buildAuthButton(String text, Function onPress) {
    return ElevatedButton(
      onPressed: isLoading ? null : () => onPress(),
      child: isLoading
          ? CircularProgressIndicator(color: Colors.white)
          : Text(text, style: TextStyle(fontSize: 16)),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 50),
        backgroundColor: Colors.teal,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: isLogin ? renderLogin() : renderSignUp(),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AuthScreen(),
  ));
}
