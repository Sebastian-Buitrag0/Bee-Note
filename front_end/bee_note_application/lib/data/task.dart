import 'package:bee_note_application/data/user.dart';

class Task{
  final String name;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final List<User> user;
  final String image;

  Task({
    required this.name, 
    required this.description, 
    required this.startDate, 
    required this.endDate, 
    required this.user, 
    required this.image
  });
}