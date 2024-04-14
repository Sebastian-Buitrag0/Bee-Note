
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class MyPhoneFormField extends StatelessWidget {

  final TextEditingController controller;
  final String hintText;
  final double paddingVertical;

  final Widget? suffixIcon;

  const MyPhoneFormField({
    super.key, 
    required this.controller, 
    required this.hintText, 
    this.paddingVertical = 5, 
    this.suffixIcon, 
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
          showCountryFlag: false,
          validator: _myPhoneNumberValidator,
          
          dropdownTextStyle: const TextStyle(
            fontFamily: 'Letters_for_Learners',
            fontSize: 23,
            color: Color.fromARGB(255, 130, 130, 130),
          ),

          
          style: const TextStyle(
            fontFamily: 'Letters_for_Learners',
            fontSize: 30,
            color: Color.fromARGB(255, 130, 130, 130),
          ),

          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            suffixIcon: suffixIcon,
          ),
          
          // onChanged: (phone) {
            // Maneja cambios en el número de teléfono
            // print('Nuevo número: ${phone.completeNumber}');
          // },

        ),
      ),
    );
  }

  FutureOr<String?> _myPhoneNumberValidator(PhoneNumber? phoneNumber){
    if (phoneNumber == null || phoneNumber.number.isEmpty) {
        return 'El campo no puede estar vacío';
    } else if (!RegExp(r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$').hasMatch(phoneNumber.toString())) {
        return 'Número de teléfono no válido';
    }
    // Retorna null si el número es válido
    return null;
  }
}