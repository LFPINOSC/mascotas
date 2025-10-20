import 'package:flutter/material.dart';
import 'package:mascotas/providers/razas_providerbd.dart';
import 'package:mascotas/widget/custom_add_button.dart';
import 'package:mascotas/widget/custom_list_widget.dart';

import 'package:provider/provider.dart';
import 'ingreso_raza_dialog.dart';
import '../models/raza.dart';

class PantallaPrincipalRazas extends StatelessWidget {
  const PantallaPrincipalRazas({super.key});

  void _mostrarIngreso(BuildContext context, {Raza? raza}) {
    showDialog(
      context: context,
      builder: (_) => IngresoRazaDialog(raza: raza),
    );
  }

  @override
  Widget build(BuildContext context) {
    final razasProvider = Provider.of<RazasProviderBD>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Gestión de Razas')),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            CustomAddButton(
              label: 'Agregar Raza',
              icon: Icons.add,
              onPressed: () => _mostrarIngreso(context),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: CustomListWidget<Raza>(
                items: razasProvider.razas,
                itemBuilder: (raza) => Row(
                  children: [
                    Expanded(
                      child: Text(
                        raza.nombre,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _mostrarIngreso(context, raza: raza),
                        ),
                        //IconButton(
                          //icon: const Icon(Icons.delete, color: Colors.red),
                          //onPressed: () => razasProvider.eliminarRaza(raza),
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
