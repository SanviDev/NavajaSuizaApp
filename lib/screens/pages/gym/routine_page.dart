import 'package:flutter/material.dart';
import 'package:navaja_suiza/modules/new/newexercises.dart';
import 'package:navaja_suiza/modules/list/exercises_list.dart';
import 'package:navaja_suiza/models/gymModel.dart';

class RoutinePage extends StatefulWidget {
  final Rutinas routine;
  const RoutinePage({Key? key, required this.routine}) : super(key: key);

  @override
  State<RoutinePage> createState() => _RoutinePageState(routine);
}

class _RoutinePageState extends State<RoutinePage> {
  final Rutinas routine;
  _RoutinePageState(this.routine);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF232332),
      appBar: AppBar(
        title: Text(routine.name),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ExercisesList(
          rutinaName: routine.name,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              backgroundColor: Colors.blueGrey[900],
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),

              context: context,
              builder: (BuildContext context) {
                return NewExercise(
                  rutina: routine,
                );
              });
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
