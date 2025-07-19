import 'package:flutter/material.dart';
import 'package:navaja_suiza/models/gymModel.dart';
import 'package:navaja_suiza/providers/gym-provider.dart';
import 'package:provider/provider.dart';

class NewRoutine extends StatelessWidget {
  NewRoutine({Key? key}) : super(key: key);
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 16.0,
        left: 16.0,
        right: 16.0,
        bottom: MediaQuery.of(context).viewInsets.bottom +
            35.0, // Asegura que el teclado no cubra el contenido
      ),
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Agregar Nueva Rutina',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 16),
            TextField(
              style: const TextStyle(color: Colors.white),
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Nombre de la Rutina',
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
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    horizontal: 32.0, vertical: 12.0),
                backgroundColor: Colors.blue, // Cambia el color del botón
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(8.0), // Bordes redondeados
                ),
              ),
              child: const Text(
                'Guardar Rutina',
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
              onPressed: () {
                // Aquí agregarías la lógica para guardar la rutina
                String name = nameController.text;
                String description = descriptionController.text;
                final Rutinas newRoutine = Rutinas(
                  name: name,
                  description: description,
                  exercises: [], // Inicializa con una lista vacía o según tu lógica
                );
                if (name.isNotEmpty && description.isNotEmpty) {
                  // Aquí podrías llamar a tu método para guardar la rutina
                  // Por ejemplo: Provider.of<GymProvider>(context, listen: false).addRoutine(name, description);
                  Provider.of<GymProvider>(context, listen: false).addRutina(newRoutine);
                  Navigator.pop(context);
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Colors.blueGrey[900],
                        title: const Text('Campos Vacíos', style: TextStyle(color: Colors.white),),
                        content: const Text('Por favor completa todos los campos', style: TextStyle(color: Colors.white),),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cerrar', style: TextStyle(color: Colors.blue),),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
            SizedBox(height: 64.0),
          ],
        ),
      ),
    );
  }
}
