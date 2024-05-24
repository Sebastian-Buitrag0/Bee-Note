import 'package:bee_note_application/data/project.dart';
import 'package:bee_note_application/data/task.dart';
import 'package:bee_note_application/ui/bottom_tap_bar.dart';
import 'package:bee_note_application/widgets/widgsts.dart';
import 'package:flutter/material.dart';

class TaskPage extends StatelessWidget {
  final Proyecto project;
  const TaskPage({
    super.key, 
    required this.project
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),

      appBar: AppBar(
        toolbarHeight: 85,
        title: const Text(
          'Tarea',
          style: TextStyle(
            fontFamily: 'Letters_for_Learners', 
            fontSize: 40, 
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFFED430),
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 45
        ),
      ),
      // body: const Center(child: Text('Screen de tarea')),
      body: ListView.builder(
        //itemCount: project.tasks.length,
        itemBuilder: (BuildContext context, int index) {
          //final task = project.tasks[index];
          //final formattDate1 = DateFormat('yyyy-MM-dd').format(task.startDate);
          //final formattDate2 = DateFormat('yyyy-MM-dd').format(task.endDate);

          //return buildTaskListTile(task, formattDate1, formattDate2);
          
        },
      ),



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
          Navigator.pushNamed(context, 'create_task');
        },
        iconData: Icons.add,
        sizewidth: 90,
        sizeHeight: 60,
      ),

    );
  }

  Padding buildTaskListTile(Task task, String formattDate1, String formattDate2) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
              
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 10),
                
        padding: const EdgeInsets.symmetric(
          horizontal: 15, 
          // vertical: paddingVertical
        ),
      
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.white),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 10),
              blurRadius: 10,
            ),
          ],
        ),
      
        child: ListTile(
          title: Text(
            task.name,
            style: const TextStyle(
              fontFamily: 'Letters_for_Learners',
              fontSize: 30,
              color: Color(0xFF3b486a),
              decorationColor: Color(0xFF3b486a)
            ),
          ),
          subtitle: Row(
            children: [
              Text(
                formattDate1,
                style: const TextStyle(
                  fontFamily: 'Letters_for_Learners',
                  fontSize: 20,
                  color: Color(0xFF3b486a),
                  decorationColor: Color(0xFF3b486a)
                ),
              ),
              const SizedBox(width: 20,),
              Text(
                formattDate2,
                style: const TextStyle(
                  fontFamily: 'Letters_for_Learners',
                  fontSize: 20,
                  color: Color(0xFF3b486a),
                  decorationColor: Color(0xFF3b486a)
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}