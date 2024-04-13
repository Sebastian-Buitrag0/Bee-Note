import "package:bee_note_application/widgets/widgsts.dart";
import "package:flutter/material.dart";

class FormLogin extends StatefulWidget {
  const FormLogin({super.key});

  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {

  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  bool _obscureText1 = true;

  final userTextController = TextEditingController();
  final passwodrTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _formState,

      child: Column(
        children: [
          const SizedBox(height: 30),
        
          // Nombre Usuario

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
      
          // Password
          MyTextFormField(
            controller: passwodrTextController,
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
        
          // Boton Iniciar Sesion
          const SizedBox(height: 25),
          HexagonalButton(
            onTap: (){
              // Lógica para el evento de tap (Iniciar sesion)
              if(_formState.currentState!.validate()){
                Navigator.pushReplacementNamed(context, 'home');
              }
              return null;

            },
            text: 'Iniciar Sesion'
          ),
        
          // Registrar
          GestureDetector(
            onTap: () {
              // Lógica para el evento de tap (registro)
              Navigator.pushReplacementNamed(context, 'register1');
            },
            child: const SizedBox(
              child: Text(
                'Registrate',
                style: TextStyle(
                  fontFamily: 'Letters_for_Learners',
                  fontSize: 30,
                  color: Color(0xFFF3753D),
                ),
              ),
            ),
          ),
        
          const Text(
            'o',
            style: TextStyle(
              fontFamily: 'Letters_for_Learners',
              fontSize: 35,
              color: Color(0xFFF3753D),
            ),
          ),
        
          // Boton de registro con Google
          const SizedBox(height: 10),
          MyButtonGoogle(onTap: (){}, text: 'Google')
        ],
      ),

    );
  }
}