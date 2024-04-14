import 'package:bee_note_application/widgets/widgsts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormRegister1 extends StatefulWidget {
  const FormRegister1({super.key});

  @override
  State<FormRegister1> createState() => _FormRegister1State();
}

class _FormRegister1State extends State<FormRegister1> {

  final nameTextController = TextEditingController();
  final lastNameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final phoneTextController = TextEditingController();
  final birthdateTextController = TextEditingController();

  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(

      key: _formState,

      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
          children: [
            const SizedBox(height: 15),
      
            // Nombres
            MyTextFormField(
              controller: nameTextController, 
              hintText: 'Nombre', 
              obscureText: false,
              paddingVertical: 0,
              validator: (value) {
                return (value == null || value.isEmpty)
                  ? 'El campo no puede estar vacio'
                  : null;
              },
            ),
        
            // Apellidos
            MyTextFormField(
              controller: lastNameTextController, 
              hintText: 'Apellido', 
              obscureText: false,
              paddingVertical: 0,
              validator: (value) {
                return (value == null || value.isEmpty)
                  ? 'El campo no puede estar vacio'
                  : null;
              },
            ),
      
            // Correo
            MyTextFormField(
              controller: emailTextController, 
              hintText: 'Correo', 
              obscureText: false,
              paddingVertical: 0,
              suffixIcon: const Icon(Icons.email),
              validator: (value) {
                
                String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
 
                RegExp regExp  = RegExp(pattern);

                return regExp.hasMatch(value ?? '')
                  ? null
                  : 'El valor ingresado no luce como un correo';
              },
            ),

            // Telefono

            //   validator: (value) {
            //     if(value!.isEmpty){
            //       return 'El campo no puede estar vacio';
            //     }else if(!RegExp(r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$').hasMatch(value)){
            //       return 'Numero no valido';
            //     }
            //     return null;
            
            MyPhoneFormField(
              controller: phoneTextController, 
              hintText: 'Telefono',
              suffixIcon: const Icon(Icons.phone_android_outlined),
              paddingVertical: 0,
            ),

            // Fecha de nacimiento
            MyTextFormField(
              controller: birthdateTextController, 
              hintText: 'Fecha de nacimiento', 
              obscureText: false,
              paddingVertical: 0,
              suffixIcon: const Icon(Icons.calendar_today_outlined),
              readOnly: true,
              showDate: true,
              onDateSelected: (DateTime selectedDate) {
                setState(() {
                  birthdateTextController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
                });
              },
              validator: (value) {
                return (value == null || value.isEmpty)
                  ? 'El campo no puede estar vacio'
                  : null;
              },
            ),
      
            // Boton Siguiente
            const SizedBox(height: 30),
            HexagonalButton(
              onTap: (){
                // Lógica para el evento de tap (Siguiente)
                // pr
                if(_formState.currentState!.validate()){
                  // print(_formState.currentState!.validate());
                  Navigator.restorablePushNamed(context, 'register2');

                }

              },
              text: 'Siguiente'
            ),
            const SizedBox(height: 30),
          ],
        ),
    );
  }
}