import "package:bee_note_application/connection/api_service.dart";
import "package:bee_note_application/providers/user_provider.dart";
import "package:bee_note_application/widgets/widgsts.dart";
import "package:flutter/material.dart";
import 'package:dio/dio.dart';
import "package:provider/provider.dart";

class FormLogin extends StatefulWidget {
  const FormLogin({super.key});

  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  bool _obscureText1 = true;
  bool _isLoading = false;

  final userTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  void dispose() {
    userTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_formState.currentState!.validate()) {
      final username = userTextController.text;
      final password = passwordTextController.text;
      setState(() {
        _isLoading = true;
      });

      try {
        // todo: NO TOCAR
        final response = await ApiService.login(username, password);

        final userProvider = Provider.of<UserProvider>(context, listen: false);
        final usuarios = await ApiService.getUsuario();

        if (usuarios.isNotEmpty) {
          final usuario = usuarios[0];
          userProvider.updateDatosPersonales(usuario.datosPersonales);
          userProvider.updateNombreUsuario(usuario.nombreUsuario);
          userProvider.updatePassword(usuario.password);
          userProvider.updateImagenPerfil(usuario.imgUrl);

          print(usuario.imgUrl.url.toString());

          Navigator.pushReplacementNamed(context, 'home');
        } else {
          // Manejar el caso cuando no se encuentran usuarios
          print('No se encontraron usuarios');
        }
      } catch (e) {
        // print('Error: $e');
        // print(e.toString());
        // print(e is DioError); // true

        String errorMessage =
            'Ocurrió un error durante el inicio de sesión. Por favor, intenta nuevamente.';

        if (e is DioError) {
          if (e.response?.statusCode == 401) {
            errorMessage =
                'Credenciales incorrectas. Por favor, verifica tu nombre de usuario y contraseña.';
          }
        }

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: Text(errorMessage),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

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
                  ? 'El campo no puede estar vacío'
                  : null;
            },
          ),

          // Password
          MyTextFormField(
            controller: passwordTextController,
            hintText: 'Contraseña',
            obscureText: _obscureText1,
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _obscureText1 = !_obscureText1;
                });
              },
              child: Icon(
                _obscureText1 ? Icons.visibility : Icons.visibility_off,
              ),
            ),
            validator: (value) {
              return (value != null && value.length >= 6)
                  ? null
                  : 'La contraseña debe de ser de 6 caracteres';
            },
          ),

          const SizedBox(height: 25),

          // Botón Iniciar Sesión
          _isLoading
              ? const CircularProgressIndicator()
              : HexagonalButton(
                  onTap: _login,
                  text: 'Iniciar Sesión',
                ),

          // Registrar
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, 'register1');
            },
            child: const SizedBox(
              child: Text(
                'Regístrate',
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

          const SizedBox(height: 10),

          // Botón de registro con Google
          MyButtonGoogle(
            onTap: () {},
            text: 'Google',
          ),
        ],
      ),
    );
  }
}
