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

  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  bool _obscureText1 = true;
  bool _obscureText2 = true;

  @override
  Widget build(BuildContext context) {
    return Form(

      key: _formState,

      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
          children: [
            const SizedBox(height: 15),
      
            // Usuario        
            MyTextFormField(
              controller: userTextController, 
              hintText: 'Usuario', 
              obscureText: false,
              validator: (value) {
                return (value == null || value.isEmpty)
                  ? 'El campo no puede estar vacio'
                  : null;
              },
            ),

            // Contraseña
            MyTextFormField(
              controller: passWordTextController, 
              hintText: 'Contraseña', 
              obscureText: _obscureText1,
              suffixIcon: GestureDetector(
                onTap: (){
                  setState(() {
                    _obscureText1 = !_obscureText1;
                  });
                },
                child: Icon(_obscureText1 ? Icons.visibility : Icons.visibility_off),
              ),
              validator: (value) {
                return (value != null && value.length >= 6) 
                  ? null 
                  : 'La contraseña debe de ser de 6 caracteres';
              },
            ),
      
            // Confirmar Contraseña
            MyTextFormField(
              controller: confirmTextController, 
              hintText: 'Confirmar contraseña', 
              obscureText: _obscureText2,
              suffixIcon: GestureDetector(
                onTap: (){
                  setState(() {
                    _obscureText2 = !_obscureText2;
                  });
                },
                child: Icon(_obscureText2 ? Icons.visibility : Icons.visibility_off),
              ),
              validator: (value) {
                return (value != null && value.length >= 6) 
                  ? null 
                  : 'La contraseña debe de ser de 6 caracteres';
              },
            ),
      
            // Boton registrarse
            const SizedBox(height: 30),
            HexagonalButton(
              onTap: (){
              // Lógica para el evento de tap (Refistrese)
              if(_formState.currentState!.validate()){
                Navigator.pushReplacementNamed(context, 'home');
              }
              return null;

            },
              text: 'Registrate'
            ),
          ],
        ),
    );
  }
}