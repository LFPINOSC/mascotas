import 'package:flutter/material.dart';

class CustomListWidget<T> extends StatefulWidget {
  final List<T> items;
  final Widget Function(T item) itemBuilder;
  final String emptyMessage;
  final void Function(T item)? onEditar;
  final void Function(T item)? onEliminar;
  final String Function(T item)? filtroString; // Función para convertir el item a texto para filtrar

  const CustomListWidget({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.emptyMessage = 'No hay elementos',
    this.onEditar,
    this.onEliminar,
    this.filtroString,
  });

  @override
  State<CustomListWidget<T>> createState() => _CustomListWidgetState<T>();
}

class _CustomListWidgetState<T> extends State<CustomListWidget<T>> {
  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    final filteredItems = widget.items.where((item) {
      if (widget.filtroString == null) return true;
      final text = widget.filtroString!(item).toLowerCase();
      return text.contains(_searchText.toLowerCase());
    }).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: const InputDecoration(
              labelText: 'Buscar...',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (value) => setState(() => _searchText = value),
          ),
        ),
        Expanded(
          child: filteredItems.isEmpty
              ? Center(
                  child: Text(
                    widget.emptyMessage,
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: filteredItems.length,
                  itemBuilder: (_, index) {
                    final item = filteredItems[index];
                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(Icons.pets, size: 36, color: Colors.teal),
                            const SizedBox(width: 12),
                            Expanded(child: widget.itemBuilder(item)),
                            if (widget.onEditar != null)
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () => widget.onEditar!(item),
                              ),
                            if (widget.onEliminar != null)
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => widget.onEliminar!(item),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
