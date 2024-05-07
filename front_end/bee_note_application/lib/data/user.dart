class User{
  final String name;
  final String image;
  final String type;

  User({
    required this.name, 
    required this.image,
    required this.type, 
  });
}

final allUser = [
  User(
    name: 'Juan', 
    image: 'assets/img/defauls_avatar_img.png', 
    type: 'Organizador'
  ),
  
  User(
    name: 'Sebastian', 
    image: 'assets/img/defauls_avatar_img.png', 
    type: 'Colaborador'
  ),
  
  User(
    name: 'Sergio', 
    image: 'assets/img/defauls_avatar_img.png', 
    type: 'Colaborador'
  ),
  
  User(
    name: 'Erick', 
    image: 'assets/img/defauls_avatar_img.png', 
    type: 'Colaborador'
  ),
  
  User(
    name: 'Fallen', 
    image: 'assets/img/defauls_avatar_img.png', 
    type: 'Lector'
  ),
  
  User(
    name: 'Jhonnatan', 
    image: 'assets/img/defauls_avatar_img.png', 
    type: 'Lector'
  ),

];