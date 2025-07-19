import 'package:flutter/material.dart';
import 'package:navaja_suiza/models/gymModel.dart';
import 'package:navaja_suiza/providers/gym-provider.dart';
import 'package:provider/provider.dart';

class NewExercise extends StatelessWidget {
  final Rutinas rutina;
  NewExercise({Key? key, required this.rutina}) : super(key: key);
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController repetitionsController = TextEditingController();
  final TextEditingController seriesController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController restController = TextEditingController();
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
              'Agregar Nuevo Ejercicio',
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
                labelText: 'Nombre del Ejercicio',
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
              controller: repetitionsController,
              decoration: const InputDecoration(
                labelText: 'Repeticiones',
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              style: const TextStyle(color: Colors.white),
              controller: seriesController,
              decoration: const InputDecoration(
                labelText: 'Series',
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              style: const TextStyle(color: Colors.white),
              controller: weightController,
              decoration: const InputDecoration(
                labelText: 'Peso (kg)',
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              style: const TextStyle(color: Colors.white),
              controller: restController,
              decoration: const InputDecoration(
                labelText: 'Descanso (min)',
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
                'Agregar Ejercicio',
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
              onPressed: () {
                // Aquí agregarías la lógica para guardar la rutina
                String name = nameController.text;
                String description = descriptionController.text;
                String repetitions = repetitionsController.text;
                String series = seriesController.text;
                String weight = weightController.text;
                String rest = restController.text;

                if (name.isNotEmpty &&
                    description.isNotEmpty &&
                    repetitions.isNotEmpty &&
                    series.isNotEmpty &&
                    weight.isNotEmpty &&
                    rest.isNotEmpty) {
                  final Exercise newExercise = Exercise(
                    name: name,
                    description: description,
                    repetitions: repetitions,
                    series: series,
                    peso: weight,
                    descanso: rest,
                  );
                  Provider.of<GymProvider>(context, listen: false)
                      .addExercise(newExercise);
                  Provider.of<GymProvider>(context, listen: false)
                      .addExerciseToRoutine(rutina, newExercise);
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
            SizedBox(height: 64.0),
          ],
        ),
      ),
    );
  }
}
