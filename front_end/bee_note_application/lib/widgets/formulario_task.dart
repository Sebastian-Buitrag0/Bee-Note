import 'package:bee_note_application/connection/api_service.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:bee_note_application/widgets/widgsts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class FormTask extends StatefulWidget {
  final String name;
  final bool showMyTextFormField;
  final int projectId;

  const FormTask({
    Key? key,
    required this.name,
    this.showMyTextFormField = false,
    required this.projectId,
  }) : super(key: key);

  @override
  State<FormTask> createState() => _FormTaskState();
}


class _FormTaskState extends State<FormTask> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final taskNameController = TextEditingController();
  final descriptionController = TextEditingController();
  DateTime _fechaInicioSeleccionada = DateTime.now();
  DateTime _fechaFinSeleccionada = DateTime.now();
  int _estadoSeleccionado = 1;
  Uint8List? _image;
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 20),
          MyTextFormField(
            controller: taskNameController,
            hintText: widget.name,
            obscureText: false,
            paddingVertical: 0,
          ),
          _BuildTextDescription(
            controller: descriptionController,
          ),
          _ParticipantButton(
            onTap: () => Navigator.pushNamed(context, 'collaborator'),
          ),
          _BuildSelectedDate(
            fechaInicioSeleccionada: _fechaInicioSeleccionada,
            fechaFinSeleccionada: _fechaFinSeleccionada,
            onFechaInicioSeleccionada: (DateTime fecha) {
              setState(() {
                _fechaInicioSeleccionada = fecha;
              });
            },
            onFechaFinSeleccionada: (DateTime fecha) {
              setState(() {
                _fechaFinSeleccionada = fecha;
              });
            },
          ),
          DropdownButtonFormField<int>(
            value: _estadoSeleccionado,
            onChanged: (value) {
              setState(() {
                _estadoSeleccionado = value!;
              });
            },
            items: const [
              DropdownMenuItem(value: 1, child: Text('Pendiente')),
              DropdownMenuItem(value: 2, child: Text('En progreso')),
              DropdownMenuItem(value: 3, child: Text('Completado')),
            ],
          ),
          _BuildSelectedImage(
            onTapContainer: () => showImagePickerOption(context),
            onTapText: () => showImagePickerOption(context),
            image: _image,
          ),
          const SizedBox(height: 20),
          HexagonalButton(
  onTap: () async {
    if (_formKey.currentState!.validate()) {
      try {
        await ApiService.createTarea(
          taskNameController.text,
          descriptionController.text,
          _fechaInicioSeleccionada,
          _fechaFinSeleccionada,
          _estadoSeleccionado,
          widget.proyecto.id, // Aquí debes pasar el ID del proyecto actual
          1, // Puedes establecer una prioridad predeterminada
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tarea creada exitosamente')),
        );
        taskNameController.clear();
        descriptionController.clear();
        setState(() {
          _fechaInicioSeleccionada = DateTime.now();
          _fechaFinSeleccionada = DateTime.now();
          _estadoSeleccionado = 1;
          _image = null;
          selectedImage = null;
        });
      } catch (e) {
        print('Error al crear la tarea: $e');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: const Text(
              'Ocurrió un error al crear la tarea. Por favor, inténtalo de nuevo.',
            ),
          ),
        );
      }
    }
    Navigator.pop(context, true);
  },
  text: 'Guardar',
),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  void showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.amber[200],
      context: context,
      builder: (builder) {
        return Padding(
          padding: const EdgeInsets.all(28.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 6.5,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _pickerImageFromGallery();
                    },
                    child: const SizedBox(
                      child: Column(
                        children: [
                          Icon(
                            Icons.image,
                            size: 70,
                            color: Color(0xFF3b486a),
                          ),
                          Text('Galería')
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _pickerImageFromCamera();
                    },
                    child: const SizedBox(
                      child: Column(
                        children: [
                          Icon(
                            Icons.camera_alt,
                            size: 70,
                            color: Color(0xFF3b486a),
                          ),
                          Text('Cámara')
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future _pickerImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    Navigator.of(context).pop();
  }

  Future _pickerImageFromCamera() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    Navigator.of(context).pop();
  }
}

class _BuildSelectedDate extends StatelessWidget {
  final DateTime fechaInicioSeleccionada;
  final DateTime fechaFinSeleccionada;
  final Function(DateTime) onFechaInicioSeleccionada;
  final Function(DateTime) onFechaFinSeleccionada;

  const _BuildSelectedDate({
    required this.fechaInicioSeleccionada,
    required this.fechaFinSeleccionada,
    required this.onFechaInicioSeleccionada,
    required this.onFechaFinSeleccionada,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: fechaInicioSeleccionada,
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );
            if (picked != null && picked != fechaInicioSeleccionada) {
              onFechaInicioSeleccionada(picked);
            }
          },
          child: Text(
            'Fecha de inicio: ${DateFormat('yyyy-MM-dd').format(fechaInicioSeleccionada)}',
          ),
        ),
        GestureDetector(
          onTap: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: fechaFinSeleccionada,
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );
            if (picked != null && picked != fechaFinSeleccionada) {
              onFechaFinSeleccionada(picked);
            }
          },
          child: Text(
            'Fecha de fin: ${DateFormat('yyyy-MM-dd').format(fechaFinSeleccionada)}',
          ),
        ),
      ],
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
    this.image,
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
                    const Icon(
                      Icons.upload_file,
                      size: 100,
                    ),
                    GestureDetector(
                      onTap: onTapText,
                      child: const Text(
                        'Subir foto',
                        style: TextStyle(
                          fontFamily: 'Letters_for_Learners',
                          fontSize: 30,
                          color: Color(0xFF3b486a),
                          decoration: TextDecoration.underline,
                          decorationColor: Color(0xFF3b486a),
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
              Icon(Icons.person_add_alt_sharp),
            ],
          ),
        ),
      ),
    );
  }
}

class _BuildTextDescription extends StatelessWidget {
  final TextEditingController controller;

  const _BuildTextDescription({
    required this.controller,
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
            hintText: 'Descripción',
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
