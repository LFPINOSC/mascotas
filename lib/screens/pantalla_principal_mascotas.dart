import 'package:flutter/material.dart';
import 'package:mascotas/providers/mascotas_providerbd.dart';
import 'package:mascotas/providers/razas_providerbd.dart';
import 'package:mascotas/widget/custom_add_button.dart';
import 'package:mascotas/widget/custom_list_widget.dart';

import 'package:provider/provider.dart';
import '../models/mascota.dart';
import 'ingreso_mascota_dialog.dart';

class PantallaPrincipalMascotas extends StatelessWidget {
  const PantallaPrincipalMascotas({super.key});

  void _abrirIngreso(BuildContext context) {
    final razasProvider = Provider.of<RazasProviderBD>(context, listen: false);

    if (razasProvider.razas.isEmpty) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Aviso'),
          content: const Text('No hay razas disponibles. Primero debe agregar una raza.'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK')),
          ],
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (_) => IngresoMascotaDialog(),
    );
  }

  void _abrirEditar(BuildContext context, Mascota mascota) {
    showDialog(
      context: context,
      builder: (_) => IngresoMascotaDialog(mascota: mascota),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mascotasProvider = Provider.of<MascotaProviderBD>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Gestión de Mascotas')),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            CustomAddButton(
              label: 'Agregar Mascota',
              icon: Icons.add,
              onPressed: () => _abrirIngreso(context),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: CustomListWidget<Mascota>(
                items: mascotasProvider.mascota,
                itemBuilder: (mascota) => Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${mascota.nombre} (${mascota.raza.nombre})',
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Dueño: ${mascota.duenio} - Tel: ${mascota.telefono}',
                            style: const TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _abrirEditar(context, mascota),
                        ),
                        //IconButton(
                          //icon: const Icon(Icons.delete, color: Colors.red),
                          //onPressed: () => mascotasProvider.eliminarMascota(mascota),
                        //),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
