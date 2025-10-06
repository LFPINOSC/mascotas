import 'package:flutter/material.dart';
import 'package:mascotas/screens/pantalla_principal_mascotas.dart';
import 'package:mascotas/screens/pantalla_principal_razas.dart';
import '../models/raza.dart';
import '../models/mascota.dart';

class InicioScreen extends StatefulWidget {
  const InicioScreen({super.key});

  @override
  State<InicioScreen> createState() => _InicioScreenState();
}

class _InicioScreenState extends State<InicioScreen> {
  List<Raza> razas = [];
  List<Mascota> mascotas = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agenda de Mascotas')),
      drawer: Drawer( // 👈 Menú lateral
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.teal),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.pets, color: Colors.white, size: 50),
                  SizedBox(height: 10),
                  Text(
                    'Agenda de Mascotas',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.pets),
              title: const Text('Gestionar Razas'),
              onTap: () async {
                Navigator.pop(context); // cerrar menú
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PantallaPrincipalRazas(
                       // pasamos la lista actual
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text('Gestionar Mascotas'),
              onTap: () async {
                Navigator.pop(context);
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PantallaPrincipalMascotas(
                      
                    ),
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Acerca de'),
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: 'Agenda de Mascotas',
                  applicationVersion: '1.0.0',
                  children: [const Text('Desarrollado por María 💚')],
                );
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text(
          'Bienvenida a la Agenda de Mascotas 🐾',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
