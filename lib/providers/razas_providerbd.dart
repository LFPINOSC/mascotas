
import 'package:flutter/material.dart';
import 'package:mascotas/BD/db_helper.dart';
import 'package:mascotas/models/raza.dart';
class  RazasProviderBD extends ChangeNotifier {
  final DbHelper _dbHelper = DbHelper();
  List<Raza> _razas=[];
  List<Raza> get razas => _razas;

  Future<void> cargarRazas() async{
    _razas= await _dbHelper.obtenerRazas();
    notifyListeners();
  }
  Future<void> agregarRazas(String nombre) async{
    final raza= Raza(id: 0, nombre: nombre);
    await _dbHelper.insertarRaza(raza);
    await cargarRazas();
  }
}