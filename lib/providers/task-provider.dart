import 'package:flutter/material.dart';
import 'package:navaja_suiza/models/taskModel.dart';

class TareaProvider with ChangeNotifier {
  List<Tarea> _tareas = [];
  List<Tarea> get tareas => _tareas;

  Future<void> loadTareas() async {
    _tareas = await Tarea.loadFromFile();
    notifyListeners();
  }

  Future<void> addTarea(Tarea tarea) async {
    _tareas.add(tarea);
    await Tarea.saveToFile(_tareas);
    notifyListeners();
  }

  Future<void> deleteTarea(int id) async {
    await Tarea.deleteTask(id);
    _tareas = await Tarea.loadFromFile();
    notifyListeners();
  }

  Future<void> editTarea(Tarea tarea) async {
    final index = _tareas.indexWhere((t) => t.id == tarea.id);
    if (index != -1) {
      _tareas[index] = tarea;
      await Tarea.saveToFile(_tareas);
      notifyListeners();
    }
  }

  int howId() {
    if (_tareas.isEmpty) return 1;
    final ids = _tareas.map((t) => t.id);
    return ids.reduce((a, b) => a > b ? a : b) + 1;
  }
}
