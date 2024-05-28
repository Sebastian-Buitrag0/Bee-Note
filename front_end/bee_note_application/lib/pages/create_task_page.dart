import 'package:bee_note_application/widgets/formulario_task.dart';
import 'package:flutter/material.dart';

class CreateTaskScreen extends StatelessWidget {

  final int proyecto;

  const CreateTaskScreen({super.key, required this.proyecto});


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
          'Crear tarea',
          style: TextStyle(
            fontFamily: 'Letters_for_Learners', 
            fontSize: 40, 
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            FormTask(
              name: 'Nombre de tarea', 
              showMyTextFormField: true,
              idPoryecto: proyecto,
            )
          ],
        ),
      ) 
    );
  }
}