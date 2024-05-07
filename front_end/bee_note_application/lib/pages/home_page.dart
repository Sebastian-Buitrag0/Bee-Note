import 'package:bee_note_application/data/project.dart';
import 'package:bee_note_application/pages/task_page.dart';
import 'package:bee_note_application/ui/bottom_tap_bar.dart';
import 'package:bee_note_application/widgets/widgsts.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
          }
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
              onPressed: () {
                
              },
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent
            ),
          )
        ],
        
      ),

      body: ListView.builder(
        itemCount: allProject.length,
          itemBuilder: (BuildContext context,int index) {
            final project = allProject[index];
            return GestureDetector(
            // todo: OnTap function
            onTap: () => Navigator.push(
              context, 
              // 'task'
              MaterialPageRoute(
                builder: (context) => TaskPage(project: project)
              )
            ),
            child: ProjectCard(project: project,)
          );
        }
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
          Navigator.pushNamed(context, 'create_project');
        },
        iconData: Icons.add,
        sizewidth: 90,
        sizeHeight: 60,
      ),
      
    );
  }
}