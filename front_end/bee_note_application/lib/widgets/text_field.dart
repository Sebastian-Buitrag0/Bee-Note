import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final double width;
  final double height;
  final bool readOnly;
  final bool showDate;
  final Function(DateTime)? onDateSelected;
  final Widget? suffixIcon;
  final String Function(String?)? validator;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.width = 500,
    this.height = 70,
    this.readOnly = false,
    this.showDate = false,
    this.onDateSelected, 
    this.suffixIcon, 
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.white),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 15),
                blurRadius: 10,
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 25),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          
          child: TextFormField(

            controller: controller,
            obscureText: obscureText,
            readOnly: readOnly,
            validator: validator,
            
            style: const TextStyle(
              fontFamily: 'Letters_for_Learners',
              fontSize: 30,
              color: Color.fromARGB(255, 130, 130, 130),
            ),

            decoration: InputDecoration(
              suffixIcon: suffixIcon,
              border: InputBorder.none,
              hintText: hintText,
            ),

          ),
        ),
        
        if (showDate)
          Positioned.fill(
            child: GestureDetector(
              onTap: () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );

                if (selectedDate != null && onDateSelected != null) {
                  onDateSelected!(selectedDate);
                }
              },
            ),
          ),
      ],
    );
  }
}
