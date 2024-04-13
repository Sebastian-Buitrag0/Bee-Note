import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFFFED430),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _BuidHeader(), 
            _BuildMeniItems()
          ],
        ),
        
      ),
    );
  }
}

class _BuidHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: const Column(
        children: [
          CircleAvatar(
            radius: 52,
            backgroundImage: AssetImage('assets/img/defauls_avatar_img.png'),
            backgroundColor: Color(0xFFFED430),
          ),
          SizedBox(height: 12,),
          Text(
            'UserName',
            style: TextStyle(
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
              Icons.home_filled,
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
