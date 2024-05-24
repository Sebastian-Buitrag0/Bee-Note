import 'package:bee_note_application/connection/api_service.dart';
import 'package:flutter/material.dart';

import 'dart:io';
import 'dart:typed_data';

import 'package:bee_note_application/widgets/widgsts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class FormProyect extends StatefulWidget {

  final String name;
  final bool showMyTextFormField;
  

  const FormProyect({
    super.key, 
    required this.name, 
    this.showMyTextFormField = false
  });

  @override
  State<FormProyect> createState() => _FormProyetcStaet();
}

class _FormProyetcStaet extends State<FormProyect> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final projectNamwController = TextEditingController();
  final descriptionController = TextEditingController();
  final starDateController = TextEditingController();
  final endDateController = TextEditingController();

  Uint8List? _image;
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 20,),

          // Nombre de proyecto
          MyTextFormField(
            controller: projectNamwController, 
            hintText: widget.name, 
            obscureText: false,
            paddingVertical: 0,
            
          ),

          // descripcion
          _BuilTextDescription(
            controller: descriptionController,
          ),

          // Agregar participantes
          _ParticipantButton(
            onTap: () => Navigator.pushNamed(context, 'collaborator'),
          ),

          _BuildSelectedDate(
            starDateController: starDateController,
            endDateController: endDateController,
            showDateField: widget.showMyTextFormField,
          ),

          // cargar imagen
          _BuildSelectedImage(
            onTapContainer: () => showImagePckerOption(context),
            onTapText: () => showImagePckerOption(context),
            image: _image,
          ),

          const SizedBox(height: 20,),
          HexagonalButton(
  onTap: () async {
    print('Guardar');
    if (_formKey.currentState!.validate()) {
      try {
        // Llamar al método createProyecto de ApiService
        await ApiService.createProyecto(
          projectNamwController.text,
          descriptionController.text,
          DateTime.parse("2003-03-03"),
          DateTime.parse("2003-03-03"),
          1, // Aquí puedes asignar el ID del estado deseado
        );
        // Proyecto creado exitosamente
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Proyecto creado exitosamente')),
        );
        // Limpiar los campos del formulario después de crear el proyecto
        projectNamwController.clear();
        descriptionController.clear();
        starDateController.clear();
        endDateController.clear();
      } catch (e) {
        // Manejar el error de creación del proyecto
        print('Error al crear el proyecto: $e');
        // Mostrar un mensaje de error al usuario
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Ocurrió un error al crear el proyecto. Por favor, inténtalo de nuevo.'),
          ),
        );
      }
    }
    Navigator.pop(context);
  },
  text: 'Guardar',
  
),

          const SizedBox(height: 20,),
        ],
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

class _BuildSelectedDate extends StatelessWidget {
  final bool showDateField;
  final TextEditingController starDateController;
  final TextEditingController endDateController;

  const _BuildSelectedDate({
    required this.showDateField,
    required this.starDateController, 
    required this.endDateController,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        if (showDateField) {
          return Column(
            children: [
              MyTextFormField(
                controller: starDateController,
                hintText: 'Inicio de la tarea',
                obscureText: false,
                paddingVertical: 0,
                suffixIcon: const Icon(Icons.calendar_today_outlined),
                readOnly: true,
                showDate: true,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                onDateSelected: (DateTime selectedDate) {
                  starDateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
                },
                validator: (value) {
                  return (value == null || value.isEmpty)
                      ? 'El campo no puede estar vacio'
                      : null;
                },
              ),

              MyTextFormField(
                controller: endDateController,
                hintText: 'Cierre de la tarea',
                obscureText: false,
                paddingVertical: 0,
                suffixIcon: const Icon(Icons.calendar_today_outlined),
                readOnly: true,
                showDate: true,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                onDateSelected: (DateTime selectedDate) {
                  starDateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
                },
                validator: (value) {
                  return (value == null || value.isEmpty)
                      ? 'El campo no puede estar vacio'
                      : null;
                },
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class _BuildSelectedImage extends StatelessWidget {

  final Function() onTapContainer;
  final Function() onTapText;
  final Uint8List? image;

  const _BuildSelectedImage({
    required this.onTapContainer, 
    required this.onTapText, 
    this.image ,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 7.5),

      child: GestureDetector(

        onTap: onTapContainer,

        child: Container(
        
          width: double.infinity,
          decoration: _buildBoxDecoration(),
        
          height: 200,

          child: image != null
            ? ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: SizedBox(
                width: double.infinity,
                height: 200,
                child: Image.memory(
                  image!,
                  fit: BoxFit.cover,
                ),
              ),
            )
            : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.upload_file, size: 100,),
                GestureDetector(
                  onTap: onTapText,
                  child: const Text(
                    'Subir foto',
                    style: TextStyle(
                      fontFamily: 'Letters_for_Learners',
                      fontSize: 30,
                      color: Color(0xFF3b486a),
                      decoration: TextDecoration.underline,
                      decorationColor: Color(0xFF3b486a)
                    ),
                  ),
                ),
              ],
            ),

        ),
      ),
    );
  }
  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
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
    );
  }  
}

class _ParticipantButton extends StatelessWidget {
  final VoidCallback onTap;
  
  const _ParticipantButton({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 7.5),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
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
          
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Agregar participantes',
                style: TextStyle(
                  fontFamily: 'Letters_for_Learners',
                  fontSize: 30,
                  color: Color.fromARGB(255, 130, 130, 130),
                ),
              ),

              Icon(Icons.person_add_alt_sharp)
            ],
          ),

        ),
      ),
    );
  }
}

class _BuilTextDescription extends StatelessWidget {
  final TextEditingController controller;

  const _BuilTextDescription({
    required this.controller
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 7.5),
      child: Container(
      
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        
        decoration: _buildBoxDecoration(),
      
        child: TextFormField(

          controller: controller,
          minLines: 1,
          maxLines: 4,

          style: const TextStyle(
            fontFamily: 'Letters_for_Learners',
            fontSize: 30,
            color: Color.fromARGB(255, 130, 130, 130),
          ),

          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Descripcion',
          ),
        )
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
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
    );
  }
}