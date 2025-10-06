import 'package:flutter/material.dart';
import '../models/raza.dart';

class ListadoRazas extends StatefulWidget {
  final List<Raza> razas;
  final VoidCallback onActualizar;
  final void Function(Raza)? onEditar;

  const ListadoRazas({
    super.key,
    required this.razas,
    required this.onActualizar,
    this.onEditar,
  });

  @override
  State<ListadoRazas> createState() => _ListadoRazasState();
}

class _ListadoRazasState extends State<ListadoRazas> {
  String _filtro = '';

  @override
  Widget build(BuildContext context) {
    // Filtrar razas por nombre
    final razasFiltradas = widget.razas
        .where((r) => r.nombre.toLowerCase().contains(_filtro.toLowerCase()))
        .toList();

    return Column(
      children: [
        // Campo de búsqueda
        TextField(
          decoration: const InputDecoration(
            labelText: 'Buscar raza',
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: (value) => setState(() => _filtro = value),
        ),
        const SizedBox(height: 10),
        // Lista de razas
        Expanded(
          child: razasFiltradas.isEmpty
              ? const Center(child: Text('No hay razas'))
              : ListView.builder(
                  itemCount: razasFiltradas.length,
                  itemBuilder: (_, i) {
                    final raza = razasFiltradas[i];
                    return ListTile(
                      title: Text(raza.nombre),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Botón Editar
                          if (widget.onEditar != null)
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => widget.onEditar!(raza),
                            ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
