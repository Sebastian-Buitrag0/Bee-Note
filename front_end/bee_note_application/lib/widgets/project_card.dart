import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

class ProjectCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: const EdgeInsets.only(top: 40, ),
        width: double.infinity,
        height: 300,
        decoration: _cardProjects(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [

            _BackgroundImage(),

            _ProjectDetails()

          ],
        ),
      ),
    );
  }

  BoxDecoration _cardProjects() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 10,
            offset: Offset(0, 5)
          )
        ]
      );
  }
}

class _ProjectDetails extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      width: double.infinity,
      height: 90,
      decoration: _buidBoxDecoration(),
      
      child: const FittedBox(
        fit: BoxFit.contain,
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nombre de proyectos #', 
              style: TextStyle(
                fontFamily: 'Letters_for_Learners',
                color: Colors.white,
                fontSize: 30
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              children: [
                Icon(Icons.calendar_today_outlined, color: Colors.white, size: 20,),
                SizedBox(width: 5,),
                Text(
                  '02/06/2055',
                  style: TextStyle(
                    fontFamily: 'Letters_for_Learners',
                    color: Colors.white,
                    fontSize: 20
                  ),
                )
              ],
            )
          ],
        
        ),
      ),
      
    );
  }

  BoxDecoration _buidBoxDecoration() => const BoxDecoration(
    color: Color(0xFF3b486a),
    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30))
  );
}

class _BackgroundImage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: const SizedBox(
        width: double.infinity,
        height: 300,
        child: FadeInImage(
          placeholder: AssetImage('assets/img/loading.gif'),
          image: AssetImage('assets/img/no_image.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}