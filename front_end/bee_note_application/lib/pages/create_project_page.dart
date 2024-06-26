import 'package:bee_note_application/widgets/formulario_proyecto.dart';
import 'package:flutter/material.dart';

class CreateProjectScreen extends StatelessWidget {

  const CreateProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),


      appBar: AppBar(
        backgroundColor: const Color(0xFFFED430),
        toolbarHeight: 85,
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 45,
        ),
        title: const Text(
          'Crear proyecto',
          style: TextStyle(
            fontFamily: 'Letters_for_Learners', 
            fontSize: 40, 
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),

      body: const SingleChildScrollView(
        child: Column(
          children: [
            FormProyect(name: 'Nombre de proyecto',)
          ],
        ),
      ) 
    );
  }
}