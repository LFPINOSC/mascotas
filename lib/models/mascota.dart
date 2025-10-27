import 'raza.dart';

class Mascota {
  final int id;
  final String nombre;
  final int edad;
  final Raza raza;
  final String duenio;
  final String telefono;
  final String? imagen;

  Mascota({
    required this.id,
    required this.nombre,
    required this.edad,
    required this.raza,
    required this.duenio,
    required this.telefono,
    this.imagen
  });
}
