import 'package:flutter/material.dart';

class CustomBottomBar extends StatelessWidget {

  final IconData iconLeft;
  final IconData iconRight;
  final Function()? onPressedLeft;
  final Function()? onPressedRight;

  const CustomBottomBar({
    super.key, 
    required this.iconLeft, 
    required this.iconRight, 
    this.onPressedLeft, 
    this.onPressedRight
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 15,
            offset: Offset(0,-15)
          )
        ]
      ),
      child: BottomAppBar(
        color: const Color(0xFFFED430),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: onPressedLeft, 
              icon: Icon(iconLeft),
              color: Colors.white,
              iconSize: 40,
            ),
            const SizedBox(width: 200,),
            IconButton(
              onPressed: onPressedRight, 
              icon: Icon(iconRight),
              color: Colors.white,
              iconSize: 40,
            )
      
          ],
        ),
      ),
    );
  }
}