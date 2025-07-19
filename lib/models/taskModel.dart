import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class Tarea {
  int id;
  String titulo;
  String descripcion;
  String? categoria;
  DateTime? fechaLimite;
  int prioridad;
  bool completada;

  Tarea({
    required this.id,
    required this.titulo,
    required this.descripcion,
    this.categoria,
    this.fechaLimite,
    required this.prioridad,
    this.completada = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'descripcion': descripcion,
      'categoria': categoria,
      'fechaLimite': fechaLimite?.toIso8601String(),
      'prioridad': prioridad,
      'completada': completada,
    };
  }

  static Future <void> saveToFile(List<Tarea> tareas) async {
    final dir = await getApplicationDocumentsDirectory();
    final filePath = '${dir.path}/tareas.json';
    final file = File(filePath);
    if (!await file.exists()) {
      await file.create(recursive: true);
    }
    await file.writeAsString(json.encode(tareas.map((t) => t.toJson()).toList()));
  }
  static Future<List<Tarea>> loadFromFile() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final filePath = '${dir.path}/tareas.json';
      final file = File(filePath);
      final contents = await file.readAsString();
      final List<dynamic> jsonData = json.decode(contents);
      return jsonData.map((json) => Tarea.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }
  static Future<void> deleteTask(int id) async {
    List<Tarea> tareas = await loadFromFile();
    tareas.removeWhere((tarea) => tarea.id == id);
    await saveToFile(tareas);
  }

  String toJsonString() {
    return json.encode(toJson());
  }

  factory Tarea.fromJson(Map<String, dynamic> json) {
    return Tarea(
      id: json['id'],
      titulo: json['titulo'],
      descripcion: json['descripcion'],
      categoria: json['categoria'],
      fechaLimite: json['fechaLimite'] != null
          ? DateTime.parse(json['fechaLimite'])
          : null,
      prioridad: json['prioridad'],
      completada: json['completada'] ?? false,
    );
  }

}