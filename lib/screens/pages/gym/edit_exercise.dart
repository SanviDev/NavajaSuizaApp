import 'package:flutter/material.dart';
import 'package:navaja_suiza/models/gymModel.dart';
import 'package:navaja_suiza/providers/gym-provider.dart';
import 'package:provider/provider.dart';

class EditExercise extends StatelessWidget {
  final Exercise ejercicio;
  final Rutinas rutina;
  const EditExercise(
      {super.key, required this.ejercicio, required this.rutina});

  @override
  Widget build(BuildContext context) {

    final TextEditingController nameController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController repsController = TextEditingController();
    final TextEditingController seriesController = TextEditingController();
    final TextEditingController weightController = TextEditingController();
    final TextEditingController restController = TextEditingController();


    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Ejercicio'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController..text = ejercicio.name,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: descriptionController..text = ejercicio.description,
              decoration: InputDecoration(labelText: 'Descripción'),
            ),
            TextField(
              controller: repsController..text = ejercicio.repetitions.toString(),
              decoration: InputDecoration(labelText: 'Repeticiones'),
            ),
            TextField(
              controller: seriesController..text = ejercicio.series.toString(),
              decoration: InputDecoration(labelText: 'Series'),
            ),
            TextField(
              controller: weightController..text = ejercicio.peso.toString(),
              decoration: InputDecoration(labelText: 'Peso'),
            ),
            TextField(
              controller: restController..text = ejercicio.descanso.toString(),
              decoration: InputDecoration(labelText: 'Descanso'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Color del botón
                padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0), // Bordes redondeados
                ),
              ),
              onPressed: () {
                final name = nameController.text;
                final description = descriptionController.text;
                final reps = repsController.text;
                final series = seriesController.text;
                final weight = weightController.text;
                final rest = restController.text;
                if (name.isEmpty ||
                    description.isEmpty ||
                    reps.isEmpty ||
                    series.isEmpty ||
                    weight.isEmpty ||
                    rest.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Error'),
                        content: Text('Por favor, completa todos los campos.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text('Aceptar'),
                          ),
                        ],
                      );
                    },
                  );
                }
                final updatedExercise = Exercise(
                  name: name,
                  description: description,
                  repetitions: reps,
                  series: series,
                  peso: weight,
                  descanso: rest,
                );
                Provider.of<GymProvider>(context, listen: false).editExercise(rutina, updatedExercise);
                Navigator.of(context).pop();
              },
              child: Text('Guardar Cambios', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
