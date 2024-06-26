import 'dart:async';
import 'package:flutter/material.dart';
import 'package:bee_note_application/data/project.dart';
import 'package:bee_note_application/pages/task_page.dart';
import 'package:bee_note_application/ui/bottom_tap_bar.dart';
import 'package:bee_note_application/widgets/widgsts.dart';
import 'package:bee_note_application/connection/api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Proyecto> _proyectos = [];

  @override
  void initState() {
    super.initState();
    _getProyectosPeriodically();
  }

  Future<void> _getProyectos() async {
    try {
      final proyectos = await ApiService.getProyectos();
      setState(() {
        _proyectos = proyectos;
      });
    } catch (e) {
      // Handle error according to your needs
      print('Error al obtener los proyectos: $e');
    }
  }

  void _getProyectosPeriodically() {
    _getProyectos(); // Initial fetch
    // Poll for updates every 30 seconds
    Timer.periodic(Duration(seconds: 10), (timer) {
      _getProyectos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      drawer: const SideMenu(),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFED430),
        toolbarHeight: 85,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const ImageIcon(
                AssetImage('assets/img/dehazer-removebg-preview.png'),
                size: 50,
                color: Colors.white,
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            );
          },
        ),
        title: const Text(
          'Projectos',
          style: TextStyle(
            fontFamily: 'Letters_for_Learners',
            fontSize: 40,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.white,
                size: 45,
              ),
              onPressed: () {},
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _proyectos.length,
        itemBuilder: (BuildContext context, int index) {
          final project = _proyectos[index];
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TaskPage(project: project)),
            ),
            child: ProjectCard(project: project),
          );
        },
      ),
      bottomNavigationBar: CustomBottomBar(
        iconLeft: Icons.info_outline,
        onPressedLeft: () {
          // Lógica del botón izquierdo
        },
        iconRight: Icons.search,
        onPressedRight: () {
          // Lógica del botón derecho
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: HexagonalButton(
        onTap: () async {
          // Lógica para el botón hexagonal
          final result = await Navigator.pushNamed(context, 'create_project');
          if (result == true) {
            // No necesitas actualizar manualmente, los cambios se reflejarán automáticamente
          }
        },
        iconData: Icons.add,
        sizewidth: 90,
        sizeHeight: 60,
      ),
    );
  }
}
