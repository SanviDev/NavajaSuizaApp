import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

List<Exercise> parseExercises(String jsonString) {
  final jsonData = json.decode(jsonString);
  return List<Exercise>.from(
    jsonData.map((item) => Exercise.fromJson(item)),
  );
}

class Rutinas {
  final String name;
  final String description;
  final List<Exercise>? exercises;

  Rutinas({required this.name, required this.description, this.exercises});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'exercises': exercises?.map((e) => e.toJson()).toList(),
    };
  }

  String toJsonString() {
    return json.encode(toJson());
  }

  static Future<void> saveToFile(List<Rutinas> rutinas) async {
    final dir = await getApplicationDocumentsDirectory();
    final filePath = '${dir.path}/rutinas.json';
    final file = File(filePath);
    await file
        .writeAsString(json.encode(rutinas.map((r) => r.toJson()).toList()));
  }

  static Future<List<Rutinas>> loadFromFile() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final filePath = '${dir.path}/rutinas.json';
      final file = File(filePath);
      final contents = await file.readAsString();
      final List<dynamic> jsonData = json.decode(contents);
      return jsonData.map((json) => Rutinas.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  static Future<void> updateRoutine(Rutinas updatedRoutine) async {
    List<Rutinas> rutinas = await loadFromFile();
    int index = rutinas.indexWhere((r) => r.name == updatedRoutine.name);
    if (index != -1) {
      rutinas[index] = updatedRoutine;
      await saveToFile(rutinas);
    }
  }


  static Future<void> editExercisesOfRoutine(
      Rutinas rutina, Exercise ejercicio) async {
    List<Rutinas> allRutinas = await loadFromFile();
    int indexRoutine = allRutinas.indexWhere((r) => r.name == rutina.name);
    if (indexRoutine != -1) {
      int indexExercise =
          rutina.exercises!.indexWhere((e) => e.name == ejercicio.name);
      if (indexExercise != -1) {
        rutina.exercises![indexExercise] = ejercicio;
        final newRoutine = Rutinas(
            name: rutina.name,
            description: rutina.description,
            exercises: rutina.exercises);
        await updateRoutine(newRoutine);
      }
    }
  }

  factory Rutinas.fromJson(Map<String, dynamic> json) {
    return Rutinas(
      name: json['name'],
      description: json['description'],
      exercises: List<Exercise>.from(
          json['exercises'].map((x) => Exercise.fromJson(x))),
    );
  }
}

class Exercise {
  final String name;
  final String description;
  final String series;
  final String repetitions;
  final String? peso;
  final int? discos;
  final String descanso;
  final String? musculos;

  Exercise(
      {required this.name,
      required this.description,
      required this.series,
      required this.repetitions,
      this.peso,
      this.discos,
      required this.descanso,
      this.musculos});
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'series': series,
      'repetitions': repetitions,
      'peso': peso,
      'discos': discos,
      'descanso': descanso,
      'musculos': musculos
    };
  }

  String toJsonString() {
    return json.encode(toJson());
  }

  static Future<void> saveToFile(List<Exercise> ejercicios) async {
    final dir = await getApplicationDocumentsDirectory();
    final filePath = '${dir.path}/exercises.json';
    final file = File(filePath);
    await file
        .writeAsString(json.encode(ejercicios.map((e) => e.toJson()).toList()));
  }

  static Future<List<Exercise>> loadFromFile() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final filePath = '${dir.path}/exercises.json';
      final file = File(filePath);
      final contents = await file.readAsString();
      final List<dynamic> jsonData = json.decode(contents);
      return jsonData.map((json) => Exercise.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      name: json['name'],
      description: json['description'],
      series: json['series'],
      repetitions: json['repetitions'],
      peso: json['peso'] != null ? json['peso'] as String : null,
      discos: json['discos'] != null ? json['discos'] as int : null,
      descanso: json['descanso'].toString(),
      musculos: json['musculos'] != null ? json['musculos'] as String : '',
    );
  }
}
