import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/mascota.dart';
import '../providers/mascotas_provider.dart';

class ListadoMascotas extends StatelessWidget {
  final void Function(Mascota) onEditar;

  const ListadoMascotas({super.key, required this.onEditar});

  @override
  Widget build(BuildContext context) {
    final mascotasProvider = Provider.of<MascotasProvider>(context);
    final mascotas = mascotasProvider.mascotas;

    if (mascotas.isEmpty) {
      return const Center(child: Text('No hay mascotas'));
    }

    return ListView.builder(
      itemCount: mascotas.length,
      itemBuilder: (_, i) {
        final m = mascotas[i];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: ListTile(
            title: Text('${m.nombre} (${m.raza.nombre})', style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('Dueño: ${m.duenio} - Tel: ${m.telefono}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () => onEditar(m),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => mascotasProvider.eliminarMascota(m),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
