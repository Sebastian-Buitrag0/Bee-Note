import 'package:bee_note_application/data/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CollaboratorPage extends StatefulWidget {
  const CollaboratorPage({super.key});

  @override
  State<CollaboratorPage> createState() => _CollaboratorPageState();
}

class _CollaboratorPageState extends State<CollaboratorPage> {
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
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 45
        ),
      ),
      
      body: ListView.builder(
        itemCount: allUser.length,

        itemBuilder: (context, index){
          final user = allUser[index];
          
          return Slidable(
            key: Key(user.name),
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
              ]
            ),
            child: buildUsreListTile(user),
          );
        },
      )

    );
  }

  void _onDismissed(int index){
    final user = allUser[index];
    setState(() {
      allUser.removeAt(index);
    });

    _showSnackBar(context, '${user.name} fue eliminado', Colors.red.shade600);
  }

  void _showSnackBar(BuildContext context, String messege, Color color){
    final snackBar = SnackBar(content: Text(messege), backgroundColor: color,);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Padding buildUsreListTile(User user) {
    return Padding(

      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
      
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 15),
                
        padding: const EdgeInsets.symmetric(
          horizontal: 15, 
          // vertical: paddingVertical
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
      
        child: Builder(
          builder: (context) {
            return ListTile(
            
              onTap: (){
                final slidable = Slidable.of(context)!;
                final isClosed = slidable.actionPaneType.value == ActionPaneType.none;
                if(isClosed){
                  slidable.openEndActionPane();
                }else{
                  slidable.close();
                }
              },
            
              title: Text(
                user.name,
                style: const TextStyle(
                  fontFamily: 'Letters_for_Learners',
                  fontSize: 30,
                  color: Color(0xFF3b486a),
                  decorationColor: Color(0xFF3b486a)
                ),
              ),
              subtitle: Text(
                user.type,
                style: const TextStyle(
                  fontFamily: 'Letters_for_Learners',
                  fontSize: 20,
                  color: Color(0xFF3b486a),
                  decorationColor: Color(0xFF3b486a)
                ),
              ),
            
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(
                  user.image
                ),
              ),
            
            );
          }
        ),
      ),
    );
  }
}