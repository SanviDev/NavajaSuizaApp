import 'package:flutter/material.dart';
import 'package:navaja_suiza/providers/account-provider.dart';
import 'package:navaja_suiza/screens/pages/password_gestor/all_accounts.dart';
import 'package:provider/provider.dart';

class SignInPG extends StatelessWidget {
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF232343),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Inicio de Sesión - Gestor de Contraseñas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 50),
              Text('Inicia sesión para continuar',
                  style: TextStyle(fontSize: 18, color: Colors.white)),
              SizedBox(height: 20),
              Text('Ingresa tu contraseña para continuar',
                  style: TextStyle(color: Colors.white)),
              SizedBox(height: 40),
              TextField(
                style: const TextStyle(color: Colors.white),
                controller: passwordController,
                onChanged: (value) {
                  context.read<AccountProvider>().setPassword(value);
                },
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32.0, vertical: 12.0),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () async {
                  if (passwordController.text.isNotEmpty) {
                    final confirmation = await Provider.of<AccountProvider>(
                            context,
                            listen: false)
                        .isCorrectPassword(passwordController.text);
                    //! se envia al widhet sea o no correcta la contraseña

                    //* Hubo un intento de fix al corregir el else (devolver un AlertDialog en lugar de un Scaffold no se cuanto)
                    //* Aún no se ha debugueado el programa, por lo que no se sabe si funciona correctamente.
                    if (confirmation) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AllAccounts()));
                    } else {
                      AlertDialog(
                        title: const Text('Contraseña Incorrecta'),
                        content: const Text(
                            'La contraseña ingresada es incorrecta. Inténtalo de nuevo.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Aceptar'),
                          ),
                        ],
                      );
                    }
                  }
                },
                child: const Text('Iniciar Sesión',
                    style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
