
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class MyPhoneFormField extends StatelessWidget {

  final TextEditingController controller;
  final String hintText;
  final double paddingVertical;

  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  const MyPhoneFormField({
    super.key, 
    required this.controller, 
    required this.hintText, 
    this.paddingVertical = 5, 
    this.suffixIcon, 
    this.validator
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 7.5),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: paddingVertical),
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
        child: IntlPhoneField(

          controller: controller,
          initialCountryCode: 'CO', // Ajusta esto según sea necesario
          // validator: validator,
          
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            suffixIcon: suffixIcon,
          ),
          
          onChanged: (phone) {
            // Maneja cambios en el número de teléfono
            print('Nuevo número: ${phone.completeNumber}');
          },
        ),
      ),
    );
  }
}