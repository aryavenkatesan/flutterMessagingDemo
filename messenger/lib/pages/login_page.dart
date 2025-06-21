import 'package:flutter/material.dart';
import 'package:messenger/components/my_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              //logo
              const Icon(Icons.message, size: 80),

              //welcome back message
              const Text(
                "Welcome back! You've been missed",
                style: TextStyle(fontSize: 16),
              ),

              //email textfield
              MyTextField(
                controller: emailController,
                hintText: "Email",
                obscureText: false,
              ),

              //password textfield

              //sign in button

              //not a member? register now
            ],
          ),
        ),
      ),
    );
  }
}
