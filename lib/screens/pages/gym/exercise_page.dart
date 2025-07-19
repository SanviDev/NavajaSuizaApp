import 'package:flutter/material.dart';
import 'package:navaja_suiza/models/gymModel.dart';
import 'package:navaja_suiza/providers/gym-provider.dart';
import 'package:navaja_suiza/screens/pages/gym/edit_exercise.dart';
import 'package:provider/provider.dart';

class ExerciseInfo extends StatelessWidget {
  final String ejercicioName;
  final String rutinaName;
  const ExerciseInfo(
      {super.key, required this.ejercicioName, required this.rutinaName});

  @override
  Widget build(BuildContext context) {
    return Consumer<GymProvider>(builder: (context, gymProvider, child) {
      final Rutinas rutina =
          gymProvider.rutinas.firstWhere((r) => r.name == rutinaName);
      final Exercise ejercicio =
          rutina.exercises!.firstWhere((e) => e.name == ejercicioName);
      
      return Scaffold(
        backgroundColor: Color(0xFF232332),
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Center(
              child: Text(
            ejercicio.name,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Center(
              child: Text(
            ejercicio.description,
            style: TextStyle(color: Colors.white, fontSize: 16),
          )),
          SizedBox(
            height: 30,
          ),
          Text('${ejercicio.series} series',
              style: TextStyle(color: Colors.white, fontSize: 16)),
          Text('${ejercicio.repetitions} repeticiones',
              style: TextStyle(color: Colors.white, fontSize: 16)),
          SizedBox(
            height: 16,
          ),
          Text('Peso: ${ejercicio.peso}kg',
              style: TextStyle(color: Colors.white, fontSize: 16)),
          SizedBox(
            height: 16,
          ),
          Text('Descanso: ${ejercicio.descanso}min',
              style: TextStyle(color: Colors.white, fontSize: 16)),
          SizedBox(
            height: 40,
          ),
          ElevatedButton(
            onPressed: () {
              //* Navegar a EditRoutine().
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditExercise(
                    ejercicio: ejercicio,
                    rutina: rutina,
                  ),
                ),
              );
            },
            child: Text(
              'Editar',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding:
                  const EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0), // Bordes redondeados
              ),
            ),
          ),
        ]),
      );
    });
  }
}
