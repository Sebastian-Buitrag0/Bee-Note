import 'package:bee_note_application/connection/api_service.dart';
import 'package:bee_note_application/data/user_id_nombre.dart';
import 'package:bee_note_application/widgets/boton_hexagonal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CollaboratorPage extends StatefulWidget {
  const CollaboratorPage({super.key});

  @override
  State<CollaboratorPage> createState() => _CollaboratorPageState();
}

class _CollaboratorPageState extends State<CollaboratorPage> {
  List<UserIdNombre> allUser = [];
  List<UserIdNombre> availableUsers = [];

  @override
  void initState() {
    super.initState();
    _getUsuariosDisponibles('');
  }

  Future<void> _getUsuariosDisponibles(String inicial) async {
    try {
      List<UserIdNombre> usuarios;
        usuarios = await ApiService.getUsuariosDisponibles(inicial);
      setState(() {
        availableUsers = usuarios;
      });
    } catch (e) {
      print('Error al obtener los usuarios disponibles: $e');
      // Maneja el error de acuerdo a tus necesidades
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      appBar: AppBar(
        toolbarHeight: 85,
        title: const Text(
          'Colaboradores',
          style: TextStyle(
            fontFamily: 'Letters_for_Learners',
            fontSize: 40,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFFED430),
        iconTheme: const IconThemeData(color: Colors.white, size: 45),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, allUser);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: allUser.length,
        itemBuilder: (context, index) {
          final user = allUser[index];
          return Slidable(
            key: Key(user.nombreUsuario),
            endActionPane: ActionPane(
              motion: const StretchMotion(),
              dismissible: DismissiblePane(
                onDismissed: () => _onDismissed(index),
              ),
              children: [
                SlidableAction(
                  backgroundColor: Colors.red.shade600,
                  icon: Icons.delete_forever,
                  label: 'Eliminar',
                  onPressed: (context) => _onDismissed(index),
                )
              ],
            ),
            child: buildUsreListTile(user),
          );
        },
      ),
      floatingActionButton: HexagonalButton(
        onTap: () => _showSearchBar(context),
        iconData: Icons.add,
        sizewidth: 90,
        sizeHeight: 60,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _onDismissed(int index) {
    final user = allUser[index];
    setState(() {
      allUser.removeAt(index);
    });

    _showSnackBar(
      context,
      '${user.nombreUsuario} fue eliminado',
      Colors.red.shade600,
    );
  }

  void _showSnackBar(BuildContext context, String message, Color color) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: color,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Padding buildUsreListTile(UserIdNombre user) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 15),
        padding: const EdgeInsets.symmetric(horizontal: 15),
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
        child: Builder(
          builder: (context) {
            return ListTile(
              onTap: () {
                final slidable = Slidable.of(context)!;
                final isClosed =
                    slidable.actionPaneType.value == ActionPaneType.none;
                if (isClosed) {
                  slidable.openEndActionPane();
                } else {
                  slidable.close();
                }
              },
              title: Text(
                user.nombreUsuario,
                style: const TextStyle(
                  fontFamily: 'Letters_for_Learners',
                  fontSize: 30,
                  color: Color(0xFF3b486a),
                  decorationColor: Color(0xFF3b486a),
                ),
              ),
              subtitle: Text(
                user.nombreUsuario,
                style: const TextStyle(
                  fontFamily: 'Letters_for_Learners',
                  fontSize: 20,
                  color: Color(0xFF3b486a),
                  decorationColor: Color(0xFF3b486a),
                ),
              ),
              leading: CircleAvatar(
                radius: 30,
                child: Text(user.nombreUsuario[0].toUpperCase()),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showSearchBar(BuildContext context) {
    String searchQuery = '';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Buscar usuario',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onChanged: (value) {
                        setModalState(() {
                          searchQuery = value;
                        });
                        _getUsuariosDisponibles(searchQuery);
                      },
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: availableUsers.length,
                        itemBuilder: (context, index) {
                          final user = availableUsers[index];
                          return ListTile(
                            title: Text(user.nombreUsuario),
                            subtitle: Text(user.nombreUsuario),
                            // todo: modificado
                            onTap: () {
                                setState(() {
                                  allUser.add(user);
                                });
                              },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
