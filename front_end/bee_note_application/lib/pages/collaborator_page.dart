import 'package:flutter/material.dart';

class CollaboratorPage extends StatelessWidget {
  const CollaboratorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 85,
        title: const Center(
          child: Text(
            'Colaboradores',
            style: TextStyle(
              fontFamily: 'Letters_for_Learners', 
              fontSize: 40, 
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: const Color(0xFFFED430),
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 45
        ),
      ),
      body: const Center(child: Text('Participantes page')),
    );
  }
}