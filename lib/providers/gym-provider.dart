import 'package:flutter/material.dart';
import '../models/gymModel.dart';

class GymProvider with ChangeNotifier {
  List<Rutinas> _rutinas = [];
  List<Exercise> _exercises = [];

  List<Rutinas> get rutinas => _rutinas;
  List<Exercise> get exercises => _exercises;

  Future<void> loadRutinas() async {
    final loadedRutinas = await Rutinas.loadFromFile();
    _rutinas = loadedRutinas;
    notifyListeners();
  }

  Future<void> loadExercises() async {
    final loadedExercises = await Exercise.loadFromFile();
    _exercises = loadedExercises;
    notifyListeners();
  }

  Future<void> addRutina(Rutinas rutina) async {
    _rutinas.add(rutina);
    await Rutinas.saveToFile(_rutinas); // O tu método incremental
    notifyListeners();
  }

  Future<void> addExerciseToRoutine(Rutinas rutina, Exercise exercise) async {
    final ejerciciosAntiguos = rutina.exercises ?? [];
    final Rutinas newRoutine = Rutinas(
        name: rutina.name,
        description: rutina.description,
        exercises: [...ejerciciosAntiguos, exercise]);
    await Rutinas.updateRoutine(newRoutine);

    final index = _rutinas.indexWhere((r) => r.name == rutina.name);
    if (index != -1) {
      _rutinas[index] = newRoutine;
      notifyListeners();
    }
  }

  Future<void> addExercise(Exercise exercise) async {
    _exercises.add(exercise);
    await Exercise.saveToFile(_exercises);
    notifyListeners();
  }

  Future<void> editExercise(Rutinas rutina, Exercise ejercicio) async {
    await Rutinas.editExercisesOfRoutine(rutina, ejercicio);
    final index = _rutinas.indexWhere((r) => r.name == rutina.name);
    if (index != -1) {
      _rutinas = await Rutinas.loadFromFile();
      notifyListeners();
    }
  }
}
