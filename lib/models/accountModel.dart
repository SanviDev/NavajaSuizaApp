import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class PGestorPass {
  String? contrasena;

  static Future<bool> passwordRegister() async {
    final file = File(
        '${(await getApplicationDocumentsDirectory()).path}/passwords.txt');
    if (!await file.exists() || (await file.length()) == 0) {
      return false;
    } else {
      return true;
    }
  }

  static Future<void> savePassword(String password) async {
    final file = File(
        '${(await getApplicationDocumentsDirectory()).path}/passwords.txt');
    await file.writeAsString(password);
  }

  static Future<String> getPassword() async {
    final file = File(
        '${(await getApplicationDocumentsDirectory()).path}/passwords.txt');
    return await file.readAsString();
  }
}

class Account {
  int id;
  String appName;
  String? username;
  String? email;
  String? phoneNumber;
  String? password;

  Account({required this.id, required this.appName, this.username, this.email, this.phoneNumber, this.password});

   Map<String, dynamic> toJson() {
    return {
      'id': id,
      'appName': appName,
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password,
    };
  }

  Account.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        appName = json['appName'],
        username = json['username'],
        email = json['email'],
        phoneNumber = json['phoneNumber'],
        password = json['password'];


  static Future<void> saveToFile(List<Account> list) async {
    final dir = await getApplicationDocumentsDirectory();
    final filePath = '${dir.path}/accounts.json';
    final file = File(filePath);
    await file.writeAsString(json.encode(list.map((e) => e.toJson()).toList()));
  }

  static Future<List<Account>> loadFromFile() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final filePath = '${dir.path}/accounts.json';
      final file = File(filePath);
      final contents = await file.readAsString();
      final List<dynamic> jsonData = json.decode(contents);
      return jsonData.map((json) => Account.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

}