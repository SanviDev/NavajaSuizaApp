import 'package:flutter/material.dart';
import 'package:navaja_suiza/modules/list/task_list.dart';
import 'package:navaja_suiza/modules/new/newtask.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  String? categoriaSeleccionada;
  Orden ordenActual = Orden.ninguno;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff131331),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.blue,
        elevation: 0,
        title: const Text('Tareas'),
        actions: [
          
           PopupMenuButton<String>(
            icon: const Icon(Icons.filter_list),
            onSelected: (String categoria) {
              setState(() {
                categoriaSeleccionada = categoria == 'Todas' ? null : categoria;
              });
            },
            itemBuilder: (BuildContext context) {
              return ['Todas', 'Trabajo', 'Estudio', 'Personal', 'Salud', 'Otros']
                  .map((String categoria) {
                return PopupMenuItem<String>(
                  value: categoria,
                  child: Text(categoria),
                );
              }).toList();
            },
          ),
          PopupMenuButton<Orden>(
            icon: const Icon(Icons.sort),
            onSelected: (Orden value) {
              setState(() {
                ordenActual = value;
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Orden>>[
              const PopupMenuItem<Orden>(
                value: Orden.fecha,
                child: Text('Ordenar por Fecha'),
              ),
              const PopupMenuItem<Orden>(
                value: Orden.prioridad,
                child: Text('Ordenar por Prioridad'),
              ),
              const PopupMenuItem<Orden>(
                value: Orden.ninguno,
                child: Text('Sin Orden'),
              ),
            ],
          ),
        ],
      ),
      body: TareaLista(
        categoriaSeleccionada: categoriaSeleccionada,
        orden: ordenActual,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        tooltip: 'Add Task',
        onPressed: () {
          showModalBottomSheet(
            backgroundColor: Color(0xFF232323),
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20.0),
                ),
              ),

              context: context,
              builder: (context) {
                return NewTask();
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
