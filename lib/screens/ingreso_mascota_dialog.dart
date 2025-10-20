import 'package:flutter/material.dart';
import 'package:mascotas/providers/mascotas_providerbd.dart';
import 'package:mascotas/providers/razas_providerbd.dart';
import 'package:provider/provider.dart';
import '../models/mascota.dart';
import '../models/raza.dart';
import '../widget/custom_text_field.dart';
import 'ingreso_raza_dialog.dart';

class IngresoMascotaDialog extends StatefulWidget {
  final Mascota? mascota;

  const IngresoMascotaDialog({super.key, this.mascota});

  @override
  State<IngresoMascotaDialog> createState() => _IngresoMascotaDialogState();
}

class _IngresoMascotaDialogState extends State<IngresoMascotaDialog> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nombreCtrl;
  late TextEditingController edadCtrl;
  late TextEditingController duenioCtrl;
  late TextEditingController telefonoCtrl;
  Raza? razaSeleccionada;

  @override
  void initState() {
    super.initState();
    nombreCtrl = TextEditingController(text: widget.mascota?.nombre ?? '');
    edadCtrl = TextEditingController(text: widget.mascota?.edad.toString() ?? '');
    duenioCtrl = TextEditingController(text: widget.mascota?.duenio ?? '');
    telefonoCtrl = TextEditingController(text: widget.mascota?.telefono ?? '');
    razaSeleccionada = widget.mascota?.raza;
  }

  Future<void> _agregarNuevaRaza(BuildContext context, RazasProviderBD razasProvider) async {
    // Guardamos temporalmente los datos del formulario
    final nombreTemp = nombreCtrl.text;
    final edadTemp = edadCtrl.text;
    final duenioTemp = duenioCtrl.text;
    final telefonoTemp = telefonoCtrl.text;

    // Abrimos diálogo para agregar raza
    await showDialog(
      context: context,
      builder: (_) => const IngresoRazaDialog(),
    );

    // Restauramos los datos
    nombreCtrl.text = nombreTemp;
    edadCtrl.text = edadTemp;
    duenioCtrl.text = duenioTemp;
    telefonoCtrl.text = telefonoTemp;

    // Refrescamos el estado para que aparezca la nueva raza en el dropdown
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final mascotasProvider = Provider.of<MascotaProviderBD>(context, listen: false);
    final razasProvider = Provider.of<RazasProviderBD>(context, listen: false);

    return AlertDialog(
      title: Text(widget.mascota == null ? 'Agregar Mascota' : 'Modificar Mascota'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                controller: nombreCtrl,
                label: 'Nombre',
                validator: (value) => (value == null || value.isEmpty) ? 'Ingrese un nombre' : null,
              ),
              const SizedBox(height: 8),
              CustomTextField(
                controller: edadCtrl,
                label: 'Edad',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Ingrese edad';
                  if (int.tryParse(value) == null) return 'Debe ser un número';
                  return null;
                },
              ),
              const SizedBox(height: 8),
              CustomTextField(
                controller: duenioCtrl,
                label: 'Dueño',
                validator: (value) => (value == null || value.isEmpty) ? 'Ingrese el dueño' : null,
              ),
              const SizedBox(height: 8),
              CustomTextField(
                controller: telefonoCtrl,
                label: 'Teléfono',
                keyboardType: TextInputType.phone,
                validator: (value) => (value == null || value.isEmpty) ? 'Ingrese teléfono' : null,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<Raza>(
                      decoration: const InputDecoration(
                        labelText: 'Seleccione Raza',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      value: razaSeleccionada,
                      items: razasProvider.razas
                          .map((r) => DropdownMenuItem(value: r, child: Text(r.nombre)))
                          .toList(),
                      onChanged: (value) => setState(() => razaSeleccionada = value),
                      validator: (value) => value == null ? 'Seleccione una raza' : null,
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.add, color: Colors.teal),
                    tooltip: 'Agregar nueva raza',
                    onPressed: () => _agregarNuevaRaza(context, razasProvider),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
        ElevatedButton(
          onPressed: () {
            if (!_formKey.currentState!.validate()) return;

            final nombre = nombreCtrl.text.trim();
            final edad = int.tryParse(edadCtrl.text.trim()) ?? 0;
            final duenio = duenioCtrl.text.trim();
            final telefono = telefonoCtrl.text.trim();

            if (widget.mascota == null) {
              mascotasProvider.agregarMascota(
                nombre: nombre,
                edad: edad,
                duenio: duenio,
                telefono: telefono,
                raza: razaSeleccionada!,
                razas: razasProvider.razas,

              );
            } 
            

            Navigator.pop(context);
          },
          child: const Text('Guardar'),
        ),
      ],
    );
  }
}
