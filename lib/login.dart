import 'package:flutter/material.dart';
import 'package:tp4/SQLlite/sqlite.dart';
import 'package:tp4/models/user.dart';
import 'register.dart';

class login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  
  bool isVisible = false;
  bool isLoginTrue = false;
  bool isLoginSuccessful = false;

  final db = DatabaseHelper();

  login() async {
    var response = await db.login(Users(
      usrEmail: emailController.text,
      usrPassword: passwordController.text,
    ));
    
    if (response == true) {
      setState(() {
        isLoginSuccessful = true;
        isLoginTrue = false;
      });
    } else {
      setState(() {
        isLoginTrue = true;
        isLoginSuccessful = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign In"),
        backgroundColor: Colors.teal[600],
      ),
      body: Container(
        margin: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _header(context),
            _inputField(context),
            _signup(context),
            if (isLoginTrue) 
              const Text(
                "Login failed. Please check your credentials.",
                style: TextStyle(color: Colors.red),
              ),
            if (isLoginSuccessful)
              const Text(
                "Welcome! You have successfully logged in.",
                style: TextStyle(color: Colors.green, fontSize: 18),
              ),
          ],
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return const Column(
      children: [
        Text(
          "Welcome Back",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text("Please sign in to your account"),
      ],
    );
  }

  Widget _inputField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: emailController, 
          decoration: InputDecoration(
            hintText: "Email",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            prefixIcon: const Icon(Icons.email),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: passwordController,
          decoration: InputDecoration(
            hintText: "Password",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            prefixIcon: const Icon(Icons.lock),
          ),
          obscureText: !isVisible,
        ),
        const SizedBox(height: 5),
        ElevatedButton(
          onPressed: () {
            login();
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: Colors.teal[600],
          ),
          child: const Text(
            "Login",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ],
    );
  }

  Widget _signup(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account? ", style: TextStyle(color: Colors.teal)),
        TextButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const register()));
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(color: Colors.teal),
          ),
        ),
      ],
    );
  }
}
