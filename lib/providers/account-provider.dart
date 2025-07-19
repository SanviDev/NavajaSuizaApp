import 'package:flutter/material.dart';
import 'package:navaja_suiza/models/accountModel.dart';

class AccountProvider with ChangeNotifier {
  // Aquí puedes definir las propiedades y métodos para gestionar las cuentas
  // Por ejemplo, una lista de cuentas, métodos para agregar, eliminar, etc.
  String _password = '';

  List<Account> _accounts = [];

  List<Account> get accounts => _accounts;
  String get password => _password;

  Future<void> loadPassword() async {
    _password = await PGestorPass.getPassword();
    notifyListeners();
  }

  Future<bool> register() async {
    return await PGestorPass.passwordRegister();
  }

  Future<void> savePassword(pass) async {
    _password = pass;
    await PGestorPass.savePassword(_password);
    notifyListeners();
  }
  Future<bool> isCorrectPassword(String password) async {
    String storedPassword = await PGestorPass.getPassword();
    return storedPassword == password;
  }

  void setPassword(String password) {
    PGestorPass.savePassword(password);
    _password = password;
    notifyListeners();
  }

  

  void addAccount(Account account) async {
    _accounts.add(account);
    await Account.saveToFile(_accounts);
    notifyListeners();
  }

  void updateAccount(Account account) async {
    int index = _accounts.indexWhere((a) => a.id == account.id);
    if (index != -1) {
      _accounts[index] = account;
      await Account.saveToFile(_accounts);
      notifyListeners();
    }
  }

  void deleteAccount(int id) async {
    _accounts.removeWhere((account) => account.id == id);
    await Account.saveToFile(_accounts);
    notifyListeners();
  }

  void removeAccount(int id) async {
    _accounts.removeWhere((account) => account.id == id);
    await Account.saveToFile(_accounts);
    notifyListeners();
  }

  int howId() {
    if (_accounts.isEmpty) return 1;
    final ids = _accounts.map((t) => t.id);
    return ids.reduce((a, b) => a > b ? a : b) + 1;
  }


}