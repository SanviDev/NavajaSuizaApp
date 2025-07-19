import 'package:flutter/material.dart';
import 'package:navaja_suiza/models/taskModel.dart';
import 'package:navaja_suiza/providers/task-provider.dart';
import 'package:provider/provider.dart';

class NewTask extends StatefulWidget {
  const NewTask({Key? key}) : super(key: key);

  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  String? selectCategories;
  double prioridad = 1;
  List<String> categories = [
    'Trabajo',
    'Estudio',
    'Personal',
    'Salud',
    'Otros'
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 16.0,
        left: 16.0,
        right: 16.0,
        bottom: MediaQuery.of(context).viewInsets.bottom + 35.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Agregar Nueva Tarea',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            style: const TextStyle(color: Colors.white),
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Nombre de la Tarea',
              border: OutlineInputBorder(),
              labelStyle: TextStyle(color: Colors.grey),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            style: const TextStyle(color: Colors.white),
            controller: descriptionController,
            decoration: const InputDecoration(
              labelText: 'Descripción',
              border: OutlineInputBorder(),
              labelStyle: TextStyle(color: Colors.grey),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            style: const TextStyle(color: Colors.white),
            controller: dateController,
            readOnly: true,
            decoration: const InputDecoration(
              labelText: 'Fecha Límite',
              border: OutlineInputBorder(),
              labelStyle: TextStyle(color: Colors.grey),
            ),
            onTap: () async {
              final DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2101),
              );
              if (pickedDate != null) {
                setState(() {
                  dateController.text =
                      "${pickedDate.day.toString().padLeft(2, '0')}/"
                      "${pickedDate.month.toString().padLeft(2, '0')}/"
                      "${pickedDate.year}";
                });
              }
            },
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: selectCategories,
            dropdownColor: Colors.grey[850],
            decoration: const InputDecoration(
              labelText: 'Categoría',
              border: OutlineInputBorder(),
              labelStyle: TextStyle(color: Colors.grey),
            ),
            items: categories.map((String category) {
              return DropdownMenuItem<String>(
                value: category,
                child:
                    Text(category, style: const TextStyle(color: Colors.white)),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectCategories = newValue;
              });
            },
          ),
          const SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Prioridad',
                style: TextStyle(color: Colors.white),
              ),
              Slider(
                value: prioridad,
                min: 1,
                max: 5,
                divisions: 4,
                label: prioridad.round().toString(),
                activeColor: Colors.blue,
                inactiveColor: Colors.grey[700],
                onChanged: (double value) {
                  setState(() {
                    prioridad = value;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              
              padding:
                  const EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: const Text(
              'Guardar Tarea',
              style: TextStyle(color: Colors.black, fontSize: 16.0),
            ),
            onPressed: () async {
              final id =
                  Provider.of<TareaProvider>(context, listen: false).howId();
              final name = nameController.text;
              final description = descriptionController.text;

              

              final categoria = selectCategories;
              final important = prioridad;

              if (name.isNotEmpty ||
                  description.isNotEmpty ||
                  dateController.text.isNotEmpty ||
                  categoria != null) {
                    final dateParts = dateController.text.split('/');
                final day = int.parse(dateParts[0]);
                final month = int.parse(dateParts[1]);
                final year = int.parse(dateParts[2]);
                final date = DateTime(year, month, day);
                final Tarea tarea = Tarea(
                  id: id,
                  titulo: name,
                  descripcion: description,
                  fechaLimite: date,
                  categoria: categoria,
                  prioridad: important.toInt(),
                );
                Provider.of<TareaProvider>(context, listen: false)
                    .addTarea(tarea);
                Navigator.pop(context);
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Colors.blueGrey[900],
                      title: const Text(
                        'Campos Vacíos',
                        style: TextStyle(color: Colors.white),
                      ),
                      content: const Text(
                        'Por favor completa todos los campos',
                        style: TextStyle(color: Colors.white),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Cerrar',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
            },
          ),
          const SizedBox(height: 64.0),
        ],
      ),
    );
  }
}
