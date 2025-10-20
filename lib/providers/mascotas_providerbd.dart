
import 'package:flutter/material.dart';
import 'package:mascotas/BD/db_helper.dart';
import 'package:mascotas/models/mascota.dart';
import 'package:mascotas/models/raza.dart';

class  MascotaProviderBD extends ChangeNotifier {
  final DbHelper _dbHelper = DbHelper();
  List<Mascota> _mascotas=[];
  List<Mascota> get mascota => _mascotas;

  Future<void> cargarMascota(List<Raza> razas) async{
    _mascotas= await _dbHelper.obtenerMascotas(razas);
    notifyListeners();
  }
  Future<void> agregarMascota({
    required String nombre,
    required int edad,
    required String duenio,
    required String telefono,
    required Raza raza,
    required List<Raza> razas,
  }) async { 
    final mascota= Mascota(id: 0, 
    nombre: nombre, 
    edad: edad, 
    raza: raza, duenio: 
    duenio, telefono: telefono);
    await _dbHelper.insertarMascota(mascota);
    await cargarMascota(razas);
  }
}