import 'package:flutter/material.dart';
import 'package:navaja_suiza/screens/pages/gym/exercise_page.dart';
import 'package:provider/provider.dart';
import 'package:navaja_suiza/models/gymModel.dart';
import '../../providers/gym-provider.dart';

class ExercisesList extends StatelessWidget {
  final String rutinaName; // Identificador de la rutina

  const ExercisesList({Key? key, required this.rutinaName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GymProvider>(
      builder: (context, gymProvider, child) {
        final rutina = gymProvider.rutinas.firstWhere(
          (r) => r.name == rutinaName,
          orElse: () => Rutinas(name: '', description: '', exercises: []),
        );

        final exercises = rutina.exercises ?? [];

        if (exercises.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Aún no hay ejercicios agregados a esta rutina.',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                SizedBox(height: 16),
                Text(
                  'Agrega tu primer ejercicio para comenzar.',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: exercises.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(8),
              child: Card(
                shadowColor: Colors.black,
                color: Color(0xFF232323),
                child: ListTile(
                  minTileHeight: 100,
                  title: Center(
                    child: Text(
                      exercises[index].name,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  subtitle: Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${exercises[index].series} x ${exercises[index].repetitions}',
                          style: TextStyle(color: Colors.white70),
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => ExerciseInfo(ejercicioName: exercises[index].name, rutinaName: rutina.name,)));
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
