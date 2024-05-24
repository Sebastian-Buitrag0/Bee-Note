import 'package:bee_note_application/connection/api_service.dart';
import 'package:bee_note_application/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SideMenu extends StatelessWidget {

  final String? nomrbeUsuario;
  final String? password;

  const SideMenu({
    super.key, 
    required this.nomrbeUsuario, 
    required this.password
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFFFED430),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _BuidHeader(nombreUsuario: nomrbeUsuario,), 
            _BuildMeniItems()
          ],
        ),
        
      ),
    );
  }
}

class _BuidHeader extends StatelessWidget {
  final String? nombreUsuario;

  const _BuidHeader({required this.nombreUsuario});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 52,
            backgroundImage: AssetImage('assets/img/defauls_avatar_img.png'),
            backgroundColor: Color(0xFFFED430),
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
              'Home',
              style: TextStyle(
                fontFamily: 'Letters_for_Learners',
                fontSize: 40,
                color: Colors.white
              ),
            ),
            onTap: () async {
              await ApiService.logout();
              userProvider.updateNombreUsuario(null);
              userProvider.updatePassword(null);

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
              'Home',
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
