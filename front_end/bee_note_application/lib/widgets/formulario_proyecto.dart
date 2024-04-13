import 'package:bee_note_application/widgets/text_field.dart';
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
          
          MyTextField(
            controller: projectNamwController, 
            hintText: 'Proyecto #', 
            obscureText: false
          ),

          const SizedBox(height: 10,),

          _NewWidget()
        ],
      ),
    );
  }
}

class _NewWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
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

          minLines: 1,
          maxLines: 4,

          style: const TextStyle(
            fontFamily: 'Letters_for_Learners',
            fontSize: 30,
            color: Color.fromARGB(255, 130, 130, 130),
          ),

          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Des',
          ),
        )
      ),
    );
  }
}