
import 'package:mascotas/models/mascota.dart';
import 'package:mascotas/models/raza.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static Database? _bd;
  Future<Database> get bd async{
    if(_bd != null ) return _bd!;
    _bd=await _initbd();
    return _bd!;
  }
  Future<Database> _initbd() async{
    final bdPath= await getDatabasesPath();
    final path= join(bdPath,'Mascotas');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate
    );
  }
  Future<void> _onCreate(Database bd, int version) async{
      await bd.execute(''' 
       CREATE TABLE raza (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT
       )
      ''');
      await bd.execute('''
        CREATE TABLE mascota (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nombre TEXT,
          edad INTEGER,
          duenio TEXT,
          telefono TEXT,
          razaid INTEGER,
          FOREIGN KEY(razaid) REFERENCES raza(id)
        )
      ''');
  }
  Future<int> insertarRaza(Raza raza)async{
    final database= await bd;
    return await database.insert('raza', {'nombre':raza.nombre});
  }
  Future<List<Raza>> obtenerRazas() async {
    final database= await bd;
    final List<Map<String, dynamic>> result= await database.query('raza');
    return result.map( (m) => Raza(id: m['id'], nombre: m['nombre'])).toList();
  }
  Future<int> insertarMascota(Mascota mascota) async {
    final database= await bd;
    return await database.insert('mascota', {
      'nombre': mascota.nombre, 
      'edad':mascota.edad,
      'duenio':mascota.duenio,
      'telefono': mascota.telefono,
      'razaid':mascota.raza.id
    });
  }
  Future<List<Mascota>> obtenerMascotas(List<Raza> razas) async{
    final database = await bd;
    final List<Map<String, dynamic>> result= await database.query('mascota');
    return result.map((m){ 
      final raza= razas.firstWhere((r) => r.id == m['razaid']);
      return Mascota(
        id: m['id'], 
        nombre: m['nombre'], 
        edad: m['edad'], 
        raza: raza, 
        duenio: m['duenio'], 
        telefono: m['telefono']
      );
    }).toList();
  }
}