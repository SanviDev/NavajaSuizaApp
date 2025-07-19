import 'package:flutter/material.dart';
import 'package:navaja_suiza/providers/task-provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
enum Orden { fecha, prioridad, ninguno }


class TareaLista extends StatefulWidget {
  final String? categoriaSeleccionada;
  final Orden orden;
  const TareaLista({Key? key, this.categoriaSeleccionada, this.orden = Orden.ninguno}) : super(key: key);

  @override
  State<TareaLista> createState() => _TareaListaState();
}

class _TareaListaState extends State<TareaLista> {
  @override
  void initState() {
    super.initState();
    // Verifica el nombre correcto del provider y método
    Future.microtask(() {
      final tareasProvider = Provider.of<TareaProvider>(context, listen: false);
      tareasProvider.loadTareas();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TareaProvider>(
      builder: (context, tareasProvider, child) {
        final tareasFiltradas = tareasProvider.tareas.where(
          (tarea) => widget.categoriaSeleccionada == null || tarea.categoria == widget.categoriaSeleccionada
        ).toList();

        if (widget.orden == Orden.prioridad) {
          tareasFiltradas.sort((a, b) => b.prioridad.compareTo(a.prioridad));
        } else if (widget.orden == Orden.fecha) {
          tareasFiltradas.sort((a, b) => a.fechaLimite!.compareTo(b.fechaLimite!));
        }

        if (tareasFiltradas.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'No tienes nada pendiente!!',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                SizedBox(height: 16),
                Text(
                  'Agrega una tarea para hacer... o disfruta de tu libertad...',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          );
        } else {
          return ListView.builder(
            itemCount: tareasFiltradas.length,
            itemBuilder: (context, index) {
              final tarea = tareasFiltradas[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                shadowColor: Colors.black,
                color: const Color(0xFF232323),
                child: ListTile(
                  title: Text(
                    tarea.titulo,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text("${tarea.descripcion} | ${tarea.categoria}",
                          style: const TextStyle(color: Colors.white70)),
                      const SizedBox(height: 8),
                      Text(
                        'Prioridad: ${tarea.prioridad}',
                        style: TextStyle(
                            fontSize: 16,
                            color: () {
                              switch (tarea.prioridad) {
                                case 1:
                                  return Colors.grey;
                                case 2:
                                  return Colors.blue;
                                case 3:
                                  return Colors.yellow;
                                case 4:
                                  return Colors.orange;
                                case 5:
                                  return Colors.red;
                                default:
                                  return Colors.white;
                              }
                            }()),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Fecha de entrega: ${DateFormat('dd/MM/yyyy').format(tarea.fechaLimite!)}',
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.done, color: Colors.green, size: 30),
                    onPressed: () {
                      tareasProvider.deleteTarea(tarea.id);
                    },
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
