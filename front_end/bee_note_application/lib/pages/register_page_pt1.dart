import 'package:bee_note_application/widgets/widgsts.dart';
import 'package:flutter/material.dart';

class RegisterPage1 extends StatefulWidget {
  const RegisterPage1({super.key});

  @override
  State<RegisterPage1> createState() => _RegisterPage1State();
}

class _RegisterPage1State extends State<RegisterPage1> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFFED430),

      body: SingleChildScrollView(

        child: SafeArea(
          child: Center(
            
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20,),
                  // Logo
                  SizedBox(
                    height: 200,
                    width: 200,
                    child: Image.asset('assets/img/Logo.png'),
                  ),
                      
                  // Formualrio
                  const FormRegister1()
                  
                ],
              
              ),
            ),
          ),
        ),
      ),

    );
  }
}