import 'dart:io';

import 'package:bee_note_application/widgets/widgsts.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterPage2 extends StatefulWidget {
  const RegisterPage2({super.key});

  @override
  State<RegisterPage2> createState() => _RegisterState();
}

class _RegisterState extends State<RegisterPage2> {

  Uint8List? _image;
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFFED430),
      
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(

                children: [
                  _image != null ? CircleAvatar(
                    radius: 65,
                    backgroundImage: MemoryImage(_image!),
                  ):
                  const CircleAvatar(
                    radius: 65,
                    backgroundColor: Color(0xFFFED430),
                    backgroundImage: AssetImage('assets/img/defauls_avatar_img.png'),
                  ),
                ],
                
              ),

              GestureDetector(
                onTap: () {
                  showImagePckerOption(context);
                },
                child: const SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Subir foto',
                        style: TextStyle(
                          fontFamily: 'Letters_for_Learners',
                          fontSize: 30,
                          color: Color(0xFF3b486a),
                          decoration: TextDecoration.underline,
                          decorationColor: Color(0xFF3b486a)
                        ),
                      ),
                      Icon(Icons.upload_file, color: Color(0xFF3b486a),),
                      
                    ],
                  ),
                ),
              ),

              // Formulario
              const FormRegister2(),
            ],
          ),
        ),
      ),

    );
  }

  // Mostrar imagen en Avatar
  void showImagePckerOption(BuildContext context){
    showModalBottomSheet(
      backgroundColor: Colors.amber[200],
      context: context, 
      builder: (builder){

        return Padding(
          padding: const EdgeInsets.all(28.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 6.5,
            child: Row(
              children: [
                
                Expanded(
                  child: InkWell(
                    onTap: (){
                      _pickerImageFromGallery();
                    },
                    child: const SizedBox(
                      child: Column(
                        children: [
                          Icon(Icons.image, size: 70,color: Color(0xFF3b486a),),
                          Text('Galeria')
                        ],
                      ),
                    ),
                  ),
                ),
          
                Expanded(
                  child: InkWell(
                    onTap: (){
                      _pickerImageFromCamera();
                    },
                    child: const SizedBox(
                      child: Column(
                        children: [
                          Icon(Icons.camera_alt, size: 70,color: Color(0xFF3b486a),),
                          Text('Camara')
                        ],
                      ),
                    ),
                  ),
                )

              ],
            ),
          ),
        );
      }
    );
  }

  // Cargar imagen de galeria
  Future _pickerImageFromGallery() async{
    final returnImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    if(returnImage == null) return;

    setState(() {
      selectedImage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    Navigator.of(context).pop();
  }

  // Cargar imagen de foto
  Future _pickerImageFromCamera() async{
    final returnImage = await ImagePicker().pickImage(source: ImageSource.camera);

    if(returnImage == null) return;

    setState(() {
      selectedImage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    Navigator.of(context).pop();
  }

}