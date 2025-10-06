import 'package:flutter/material.dart';
import '../models/raza.dart';

class RazasProvider extends ChangeNotifier {
  List<Raza> _razas = [];
  int _nextId = 1;

  List<Raza> get razas => _razas;

  void agregarRaza(String nombre) {
    _razas.add(Raza(id: _nextId++, nombre: nombre));
    notifyListeners();
  }

  void eliminarRaza(Raza raza) {
    _razas.remove(raza);
    notifyListeners();
  }

  void actualizar() {
    notifyListeners();
  }
}
