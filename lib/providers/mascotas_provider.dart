import 'package:flutter/material.dart';
import '../models/mascota.dart';
import '../models/raza.dart';

class MascotasProvider extends ChangeNotifier {
  List<Mascota> _mascotas = [];
  int _nextId = 1;

  List<Mascota> get mascotas => _mascotas;

  // Agregar nueva mascota
  void agregarMascota({
    required String nombre,
    required int edad,
    required String duenio,
    required String telefono,
    required Raza raza,
  }) {
    _mascotas.add(
      Mascota(
        id: _nextId++,
        nombre: nombre,
        edad: edad,
        duenio: duenio,
        telefono: telefono,
        raza: raza,
      ),
    );
    notifyListeners();
  }

  // Eliminar mascota
  void eliminarMascota(Mascota mascota) {
    _mascotas.remove(mascota);
    notifyListeners();
  }

  // Modificar mascota existente
  void modificarMascota(
    Mascota mascota, {
    required String nombre,
    required int edad,
    required String duenio,
    required String telefono,
    required Raza raza,
  }) {
    final index = _mascotas.indexWhere((m) => m.id == mascota.id);
    if (index != -1) {
      _mascotas[index] = Mascota(
        id: mascota.id,
        nombre: nombre,
        edad: edad,
        duenio: duenio,
        telefono: telefono,
        raza: raza,
      );
      notifyListeners();
    }
  }
}
