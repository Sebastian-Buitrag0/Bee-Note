import 'package:bee_note_application/data/task.dart';
import 'package:bee_note_application/data/user.dart';

class Project{
  final String name;
  final String description;
  final List<User> users;
  final String image;
  final List<Task> tasks;

  Project({
    required this.name, 
    required this.description, 
    required this.users, 
    required this.image,
    required this.tasks,
  });
}
//  todo: TIENES LA IDEA
final allProject = [
  Project(
    name: 'BeeNote', 
    description: 'Eiusmod irure esse enim eu commodo nostrud velit qui fugiat tempor aliquip nulla.', 
    users: [allUser[0], allUser[1], allUser[2], allUser[4]], 
    image: 'assets/img/fondo.png',
    tasks: [
      Task(
        name: 'Crear logo', 
        description: 'Exercitation elit quis eu irure aute labore id est aliquip.', 
        startDate: DateTime.now(), 
        endDate: DateTime.utc(2024, 12, 9), 
        user: [allUser[2]], 
        image: 'image'
      ),
      Task(
        name: 'Crear frontEnd', 
        description: 'Exercitation elit quis eu irure aute labore id est aliquip.', 
        startDate: DateTime.now(), 
        endDate: DateTime.utc(2024, 5, 7), 
        user: [allUser[0]], 
        image: 'image'
      ),
    ]
  ),

  Project(
    name: 'HostPital', 
    description: 'Amet ipsum adipisicing commodo enim exercitation enim esse non veniam occaecat duis sit Lorem fugiat.', 
    users: [allUser[0], allUser[1], allUser[2]], 
    image: 'assets/img/background_hospital.png',
    tasks: [
      Task(
        name: 'Crear Funcion de inicio de sesion', 
        description: 'Exercitation elit quis eu irure aute labore id est aliquip.', 
        startDate: DateTime.now(), 
        endDate: DateTime.utc(2024, 12, 9), 
        user: [allUser[2]], 
        image: 'image'
      ),
    ]
  ),

  Project(
    name: 'Transfercoop', 
    description: 'Incididunt Lorem laboris excepteur excepteur.', 
    users: [allUser[0], allUser[1], allUser[2]], 
    image: 'assets/img/background_banco.png',
    tasks: [
      Task(
        name: 'Crear el frontend', 
        description: 'Exercitation elit quis eu irure aute labore id est aliquip.', 
        startDate: DateTime.now(), 
        endDate: DateTime.utc(2024, 12, 9), 
        user: [allUser[2]], 
        image: 'image'
      )
    ]
  )
];