import 'package:bee_note_application/widgets/widgsts.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFFED430),
      
      body: SafeArea(
          child: Center(
            
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                SizedBox(
                  height: 200,
                  width: 200,
                  child: Image.asset('assets/img/Logo.png',),
                ),

                // Formualrio
                const FormLogin(),
                              
              ],
            ),
          ),
      ),

    );
  }
}