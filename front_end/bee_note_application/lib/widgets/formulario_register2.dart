import 'package:bee_note_application/widgets/widgsts.dart';
import 'package:flutter/material.dart';

class FormRegister2 extends StatefulWidget {
  const FormRegister2({super.key});

  @override
  State<FormRegister2> createState() => _FormRegister1State();
}

class _FormRegister1State extends State<FormRegister2> {

  final userTextController = TextEditingController();
  final passWordTextController = TextEditingController();
  final confirmTextController = TextEditingController();

  bool _obscureText1 = true;
  bool _obscureText2 = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
          children: [
            const SizedBox(height: 15),
      
            // Usuario
            MyTextField(
              controller: userTextController, 
              hintText: 'Usuario', 
              obscureText: false,
              height: 60,
            ),
        
            // Contraseña
            const SizedBox(height: 15),
            MyTextField(
              controller: passWordTextController,
              hintText: 'Contraseña',
              obscureText: _obscureText1,
              height: 60,
              suffixIcon: GestureDetector(
                onTap: (){
                  setState(() {
                    _obscureText1 = !_obscureText1;
                  });
                },
                child: Icon(_obscureText1 ? Icons.visibility : Icons.visibility_off),
              ),
            ),
      
            // Confirmar Contraseña
            const SizedBox(height: 15),
            MyTextField(
              controller: confirmTextController,
              hintText: 'Confrimar Contraseña',
              obscureText: _obscureText2,
              height: 60,
              suffixIcon: GestureDetector(
                onTap: (){
                  setState(() {
                    _obscureText2 = !_obscureText2;
                  });
                },
                child: Icon(_obscureText2 ? Icons.visibility : Icons.visibility_off),
              ),
            ),
      
      
            // Boton registrarse
            const SizedBox(height: 30),
            HexagonalButton(
              onTap: (){
                // Lógica para el evento de tap (Registrarse)
                Navigator.restorablePushNamed(context, 'home');
              },
              text: 'Registrate'
            ),
          ],
        ),
    );
  }
}