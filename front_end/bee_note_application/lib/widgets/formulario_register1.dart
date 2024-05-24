import 'package:flutter/material.dart';
import 'package:bee_note_application/providers/user_provider.dart';
import 'package:bee_note_application/widgets/widgsts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:bee_note_application/data/datos_personales.dart'; // Importa el modelo de datos

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
              String pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp = RegExp(pattern);
              return regExp.hasMatch(value ?? '')
                  ? null
                  : 'El valor ingresado no luce como un correo';
            },
          ),

          // Telefono
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
                birthdateTextController.text =
                    DateFormat('yyyy-MM-dd').format(selectedDate);
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
            onTap: () {
              print(nameTextController.text);
              print(lastNameTextController.text);
              print(emailTextController.text);
              print(phoneTextController.text);
              print(birthdateTextController.text);

              if (_formState.currentState!.validate()) {
                // Formatear la fecha antes de enviarla al servidor

                // Almacenar los datos en UserProvider
                final userProvider =
                    Provider.of<UserProvider>(context, listen: false);
                userProvider.updateDatosPersonales(DatosPersonales(
                  nombre: nameTextController.text,
                  apellido: lastNameTextController.text,
                  correo: emailTextController.text,
                  telefono: phoneTextController.text,
                  fechaNacimiento: birthdateTextController.text,
                ));
                print(
                    'Datos personales antes de navegar: ${userProvider.datosPersonales}');
                // Navegar a la segunda página de registro
                Navigator.restorablePushNamed(context, 'register2');
              }
            },
            text: 'Siguiente',
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
