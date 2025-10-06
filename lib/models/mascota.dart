import 'raza.dart';

class Mascota {
  int id;
  String nombre;
  int edad;
  Raza raza;
  String duenio;
  String telefono;

  Mascota({
    required this.id,
    required this.nombre,
    required this.edad,
    required this.raza,
    required this.duenio,
    required this.telefono,
  });
}
