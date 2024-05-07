import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {

  final TextEditingController controller;
  final String hintText;
  final double paddingVertical;
  final bool obscureText;
  final bool readOnly;
  final bool showDate;
  
  final Function(DateTime)? onDateSelected;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String? Function(String?)? validator;

  final Widget? suffixIcon;

  const MyTextFormField({
    super.key, 
    required this.controller, 
    required this.hintText, 
    required this.obscureText, 
    this.paddingVertical = 5, 
    this.readOnly = false, 
    this.suffixIcon, 
    this.showDate = false, 
    this.onDateSelected, 
    this.validator, 
    this.initialDate, 
    this.firstDate, 
    this.lastDate
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 7.5),
          child: Container(
          
            width: double.infinity,
              
            padding: EdgeInsets.symmetric(
              horizontal: 25, 
              vertical: paddingVertical
            ),
          
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.white),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 10),
                  blurRadius: 10,
                ),
              ],
            ),
          
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
        ),

        if (showDate) _buildDatePicker(context),



      ],
    );
  }

  Positioned _buildDatePicker(BuildContext context) {
    return Positioned.fill(
      child: GestureDetector(
        onTap: () async {
          final selectedDate = await showDatePicker(
            context: context,
            initialDate: initialDate ?? DateTime.now(),
            firstDate: firstDate ?? DateTime(1900),
            lastDate: lastDate ?? DateTime.now(),
          );

          if (selectedDate != null && onDateSelected != null) {
            onDateSelected!(selectedDate);
          }
        },
      ),
    );
  }
}