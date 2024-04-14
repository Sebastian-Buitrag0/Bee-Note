import 'package:bee_note_application/widgets/widgsts.dart';
import 'package:flutter/material.dart';

class FormProyect extends StatefulWidget {
  const FormProyect({super.key});

  @override
  State<FormProyect> createState() => _FormProyetcStaet();
}

class _FormProyetcStaet extends State<FormProyect> {

  final projectNamwController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          const SizedBox(height: 20,),

          MyTextFormField(
            controller: projectNamwController, 
            hintText: 'Proyecto #', 
            obscureText: false,
            paddingVertical: 0,
            
          ),

          _BuilTextDescription(
            controller: descriptionController,
          ),

          _ParticipantButton(
            onTap: () {
              print('Funciona');
            },
          )

        ],
      ),
    );
  }
}

class _ParticipantButton extends StatelessWidget {
  final VoidCallback onTap;
  
  const _ParticipantButton({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 7.5),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.white),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 15),
                blurRadius: 10,
              ),
            ],
          ),
          
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Agregar participantes',
                style: TextStyle(
                  fontFamily: 'Letters_for_Learners',
                  fontSize: 30,
                  color: Color.fromARGB(255, 130, 130, 130),
                ),
              ),

              Icon(Icons.person_add_alt_sharp)
            ],
          ),

        ),
      ),
    );
  }
}

class _BuilTextDescription extends StatelessWidget {
  final TextEditingController controller;

  const _BuilTextDescription({
    required this.controller
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 7.5),
      child: Container(
      
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.white),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 15),
              blurRadius: 10,
            ),
          ],
        ),
      
        child: TextFormField(

          controller: controller,
          minLines: 1,
          maxLines: 4,

          style: const TextStyle(
            fontFamily: 'Letters_for_Learners',
            fontSize: 30,
            color: Color.fromARGB(255, 130, 130, 130),
          ),

          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Descripcion',
          ),
        )
      ),
    );
  }
}