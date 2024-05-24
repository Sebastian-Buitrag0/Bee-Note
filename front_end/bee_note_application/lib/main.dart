import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bee_note_application/providers/user_provider.dart';
import 'package:bee_note_application/routes/routes.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: appRoutes,
    );
  }
}
