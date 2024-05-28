import 'package:bee_note_application/connection/api_service.dart';
import 'package:bee_note_application/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SideMenu extends StatelessWidget {

  const SideMenu({
    super.key, 
  });

  @override
  Widget build(BuildContext context) {

    final userProvider = Provider.of<UserProvider>(context);
    final nombreUsuario = userProvider.nombreUsuario;
    final imagenUrl = userProvider.imagenPerfil?.url;

    print('url de la imagen: $imagenUrl (sidemenu)');

    return Drawer(
      backgroundColor: const Color(0xFFFED430),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _BuidHeader(nombreUsuario: nombreUsuario, imagenPerfilUrl: imagenUrl,), 
            _BuildMeniItems()
          ],
        ),
        
      ),
    );
  }
}

class _BuidHeader extends StatelessWidget {
  final String? nombreUsuario;
  final String? imagenPerfilUrl;

  const _BuidHeader({required this.nombreUsuario, required this.imagenPerfilUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Column(
        children: [
          CircleAvatar(
            radius: 52,
            backgroundImage: imagenPerfilUrl != null
                ? NetworkImage(imagenPerfilUrl!)
                : const AssetImage('assets/img/default_avatar_img.png') as ImageProvider<Object>?,
            backgroundColor: const Color(0xFFFED430),
          ),
          const SizedBox(height: 12,),
          Text(
            nombreUsuario ?? 'Usuaeio',
            style: const TextStyle(
              fontFamily: 'Letters_for_Learners',
              fontSize: 40,
              color: Colors.white
            ),
          ),
        ],
      ),
    );
  }
}

class _BuildMeniItems extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final userProvider  = Provider.of<UserProvider>(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: [
          Divider(color: Colors.amber[200]),
          const Text(
            'Frase del dia!!!!',
            style: TextStyle(
              fontFamily: 'Letters_for_Learners',
              fontSize: 40,
              color: Colors.white
            ),
          ),
      
          Divider(color: Colors.amber[200]),
      
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Colors.white,
              size: 40,
            ),
            title: const Text(
              'Logout',
              style: TextStyle(
                fontFamily: 'Letters_for_Learners',
                fontSize: 40,
                color: Colors.white
              ),
            ),
            onTap: () async {
              await ApiService.logout();
              userProvider.updateNombreUsuario('');
              userProvider.updatePassword('');

              Navigator.pushReplacementNamed(context, 'login');
            },
          ),

          ListTile(
            leading: const Icon(
              Icons.info_outline,
              color: Colors.white,
              size: 40,
            ),
            title: const Text(
              'Info',
              style: TextStyle(
                fontFamily: 'Letters_for_Learners',
                fontSize: 40,
                color: Colors.white
              ),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
