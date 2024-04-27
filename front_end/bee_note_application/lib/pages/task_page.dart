import 'package:bee_note_application/ui/bottom_tap_bar.dart';
import 'package:bee_note_application/widgets/widgsts.dart';
import 'package:flutter/material.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),

      appBar: AppBar(
        toolbarHeight: 85,
        title: const Center(
          child: Text(
            'Tarea',
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
      body: const Center(child: Text('Screen de tarea')),



      bottomNavigationBar: CustomBottomBar(
        
          iconLeft: Icons.info_outline,
          onPressedLeft: () {
            // Logica de poton izquierdo
          },
        
          iconRight: Icons.search,
          onPressedRight: () {
            // Logica de poton derecha
          },
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: HexagonalButton(
        onTap: () {
          // Lógica para el botón hexagonal
          Navigator.pushNamed(context, 'project');
        },
        iconData: Icons.add,
        sizewidth: 90,
        sizeHeight: 60,
      ),

    );
  }
}