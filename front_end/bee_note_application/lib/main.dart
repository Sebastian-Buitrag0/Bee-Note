import 'package:bee_note_application/routes/routes.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: LoginPage(),
      initialRoute: 'login',
      routes: appRoutes,
    );
  }
}


//  El amarillo: #FED430
//  El Azul: #3C486B
//  El naranja: #F3753D
//  El Grisaceo: #F0F0F0
//  El gris mas oscuro: #BEBEBE