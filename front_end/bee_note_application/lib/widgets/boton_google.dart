import 'package:flutter/material.dart';

class MyButtonGoogle extends StatelessWidget {

  final  Function()? onTap;
  final String text;
  
  const MyButtonGoogle({
    super.key, 
    required this.onTap, 
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 10),
            blurRadius: 10,
            spreadRadius: 0
          ),
        ]
      ),

      padding: const EdgeInsets.symmetric(horizontal: 65, vertical: 3),

      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Letters_for_Learners',
          fontSize: 30
        )
      ),


    );
  }
}