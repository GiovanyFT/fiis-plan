
abstract class Objeto{
  int id;

  Objeto();

  Objeto.fromMap(Map<String, dynamic> map){
    id = map["id"];
  }

}