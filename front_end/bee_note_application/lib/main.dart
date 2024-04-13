import 'package:flutter/material.dart';
import 'package:bee_note_application/pages/screens.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: LoginPage(),
      initialRoute: 'register1',
      routes: {
        'login': ( _ ) => const LoginPage(),
        'register1': ( _ ) => const RegisterPage1(),
        'register2': ( _ ) => const RegisterPage2(),
        'home': ( _ ) => const HomePage(),
        'project': ( _ ) => const ProjectScreen(),
      },
    );
  }
}


//  El amarillo: #FED430
//  El Azul: #3C486B
//  El naranja: #F3753D
//  El Grisaceo: #F0F0F0
//  El gris mas oscuro: #BEBEBE