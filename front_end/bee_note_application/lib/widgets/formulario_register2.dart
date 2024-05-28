import 'package:bee_note_application/widgets/widgsts.dart';
import 'package:flutter/material.dart';
import 'package:bee_note_application/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:bee_note_application/connection/api_service.dart';

class FormRegister2 extends StatefulWidget {
  const FormRegister2({super.key});

  @override
  State<FormRegister2> createState() => _FormRegister2State();
}

class _FormRegister2State extends State<FormRegister2> {
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
              onTap: () {
                setState(() {
                  _obscureText1 = !_obscureText1;
                });
              },
              child:
                  Icon(_obscureText1 ? Icons.visibility : Icons.visibility_off),
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
              onTap: () {
                setState(() {
                  _obscureText2 = !_obscureText2;
                });
              },
              child:
                  Icon(_obscureText2 ? Icons.visibility : Icons.visibility_off),
            ),
            validator: (value) {
              return (value != null && value == passWordTextController.text)
                  ? null
                  : 'Las contraseñas no coinciden';
            },
          ),

          // Boton Registrar
          const SizedBox(height: 30),
          HexagonalButton(
            onTap: () async {
              print('Registrar');
              if (_formState.currentState!.validate()) {
                // Obtener los datos del UserProvider
                final userProvider =
                    Provider.of<UserProvider>(context, listen: false);
                final datosPersonales = userProvider.datosPersonales;

                print('datosPersonales: $datosPersonales');

                if (datosPersonales != null) {
                  try {
                    final imagenPerfilUrl = userProvider.imagenPerfil?.url;
                    // Llamar al método registerUser de ApiService
                    await ApiService.registerUser(
                      datosPersonales.nombre,
                      datosPersonales.apellido,
                      datosPersonales.correo,
                      datosPersonales.telefono,
                      datosPersonales.fechaNacimiento,
                      userTextController.text,
                      passWordTextController.text,
                      imagenPerfilUrl,
                    );

                    Navigator.restorablePushNamed(context, 'login');
                  } catch (e) {
                    // Manejar el error de registro
                    print('Error al registrar el usuario: $e');
                    // Mostrar un mensaje de error al usuario
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Error'),
                        content: Text(
                            'Ocurrió un error al registrar el usuario. Por favor, inténtalo de nuevo.'),
                        actions: [
                          TextButton(
                            onPressed: () =>
                                Navigator.pushNamed(context, 'home'),
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                } else {
                  // Manejar el caso en que datosPersonales sea nulo
                  print('Los datos personales no están completos');
                  // Mostrar un mensaje de error al usuario
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Error'),
                      content: Text(
                          'Por favor, completa todos los datos personales antes de registrarte.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              }
            },
            text: 'Registrar',
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
