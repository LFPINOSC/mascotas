import 'package:flutter/material.dart';
import 'package:mascotas/providers/razas_providerbd.dart';
import 'package:provider/provider.dart';
import '../models/raza.dart';

class IngresoRazaDialog extends StatefulWidget {
  final Raza? raza; // null si es agregar, no null si es modificar

  const IngresoRazaDialog({super.key, this.raza});

  @override
  State<IngresoRazaDialog> createState() => _IngresoRazaDialogState();
}

class _IngresoRazaDialogState extends State<IngresoRazaDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.raza?.nombre ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final razasProvider = Provider.of<RazasProviderBD>(context, listen: false);

    return AlertDialog(
      title: Text(widget.raza == null ? 'Agregar Raza' : 'Modificar Raza'),
      content: TextField(
        controller: _controller,
        decoration: const InputDecoration(labelText: 'Nombre de la raza'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            final nombre = _controller.text.trim();
            if (nombre.isEmpty) return;

            if (widget.raza == null) {
              // Agregar nueva raza
              razasProvider.agregarRazas(nombre);
            } else {
              // Modificar raza existente
             // widget.raza!.nombre = nombre;
              //razasProvider.agregarRazas();
            }
            Navigator.pop(context);
          },
          child: const Text('Guardar'),
        ),
      ],
    );
  }
}
