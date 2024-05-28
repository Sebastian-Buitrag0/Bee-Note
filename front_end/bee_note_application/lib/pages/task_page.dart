import 'package:bee_note_application/pages/create_task_page.dart';
import 'package:flutter/material.dart';
import 'package:bee_note_application/data/project.dart';
import 'package:bee_note_application/data/task.dart';
import 'package:bee_note_application/ui/bottom_tap_bar.dart';
import 'package:bee_note_application/widgets/widgsts.dart';
import 'package:bee_note_application/connection/api_service.dart';
import 'package:intl/intl.dart';

class TaskPage extends StatefulWidget {
  final Proyecto project;

  const TaskPage({super.key, required this.project});

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  List<Tarea> _tareas = [];

  @override
  void initState() {
    super.initState();
    print(widget.project.id);
    _getTareas(widget.project);
  }

  Future<void> _getTareas(Proyecto proyecto) async {
    final projectId = widget.project.id;

    try {
      final tareas = await ApiService.getTareasPorProyecto(projectId);
      setState(() {
        _tareas = tareas;
      });
    } catch (e) {
      print('Error al obtener las tareas: $e');
    }
      
  }

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
          size: 45,
        ),
      ),
      body: ListView.builder(
        itemCount: _tareas.length,
        itemBuilder: (BuildContext context, int index) {
          final task = _tareas[index];
          final formattedStartDate =
              DateFormat('yyyy-MM-dd').format(task.fechaInicio);
          final formattedEndDate =
              DateFormat('yyyy-MM-dd').format(task.fechaFin);

          return buildTaskListTile(task, formattedStartDate, formattedEndDate);
        },
      ),
      bottomNavigationBar: CustomBottomBar(
        iconLeft: Icons.info_outline,
        onPressedLeft: () {
          // Logica de botón izquierdo
        },
        iconRight: Icons.search,
        onPressedRight: () {
          // Logica de botón derecho
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: HexagonalButton(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateTaskScreen(proyecto: widget.project.id)),
          ).then((refreshTask){
            if(refreshTask == true){
              _getTareas(widget.project);
            }
          });
        },
        iconData: Icons.add,
        sizewidth: 90,
        sizeHeight: 60,
      ),
    );
  }

  Padding buildTaskListTile(
      Tarea task, String formattedStartDate, String formattedEndDate) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15),
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
            task.nombre, // Cambio aquí
            style: const TextStyle(
              fontFamily: 'Letters_for_Learners',
              fontSize: 30,
              color: Color(0xFF3b486a),
              decorationColor: Color(0xFF3b486a),
            ),
          ),
          subtitle: Row(
            children: [
              Text(
                formattedStartDate, // Cambio aquí
                style: const TextStyle(
                  fontFamily: 'Letters_for_Learners',
                  fontSize: 20,
                  color: Color(0xFF3b486a),
                  decorationColor: Color(0xFF3b486a),
                ),
              ),
              const SizedBox(width: 20),
              Text(
                formattedEndDate, // Cambio aquí
                style: const TextStyle(
                  fontFamily: 'Letters_for_Learners',
                  fontSize: 20,
                  color: Color(0xFF3b486a),
                  decorationColor: Color(0xFF3b486a),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
