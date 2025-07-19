import 'package:flutter/material.dart';
import 'package:navaja_suiza/models/accountModel.dart';
import 'package:navaja_suiza/providers/account-provider.dart';
import 'package:provider/provider.dart';

class Newaccount extends StatelessWidget {
  Newaccount({Key? key}) : super(key: key);
  final TextEditingController nameController = TextEditingController();
  final TextEditingController userController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController numeroController = TextEditingController();
  final TextEditingController contraController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 16.0,
        left: 16.0,
        right: 16.0,
        bottom: MediaQuery.of(context).viewInsets.bottom +
            35.0, // Asegura que el teclado no cubra el contenido
      ),
      child: Container(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Text(
            'Agregar Nueva Cuenta',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 16),
          TextField(
            style: const TextStyle(color: Colors.white),
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Nombre de la Aplicación',
              border: OutlineInputBorder(),
              labelStyle: TextStyle(color: Colors.grey),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            style: const TextStyle(color: Colors.white),
            controller: emailController,
            decoration: const InputDecoration(
              labelText: 'Correo Electrónico',
              border: OutlineInputBorder(),
              labelStyle: TextStyle(color: Colors.grey),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            style: const TextStyle(color: Colors.white),
            controller: userController,
            decoration: const InputDecoration(
              labelText: 'Usuario',
              border: OutlineInputBorder(),
              labelStyle: TextStyle(color: Colors.grey),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            style: const TextStyle(color: Colors.white),
            controller: numeroController,
            decoration: const InputDecoration(
              labelText: 'Número de Teléfono',
              border: OutlineInputBorder(),
              labelStyle: TextStyle(color: Colors.grey),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            style: const TextStyle(color: Colors.white),
            controller: contraController,
            decoration: const InputDecoration(
              labelText: 'Contraseña',
              border: OutlineInputBorder(),
              labelStyle: TextStyle(color: Colors.grey),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    horizontal: 32.0, vertical: 12.0),
                backgroundColor: Colors.blue, // Cambia el color del botón
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(8.0), // Bordes redondeados
                ),
              ),
              child: const Text(
                'Agregar Cuenta',
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
              onPressed: () {
                final List<String> datos = [
                  nameController.text,
                  userController.text,
                  emailController.text,
                  numeroController.text,
                  contraController.text
                ];
                for (var dato in datos) {
                  if (dato.isEmpty) {
                    dato = 'No aplica';
                  }
                }

                final nuevaCuenta = Account(
                  id: context.read<AccountProvider>().howId(),
                  appName: nameController.text,
                  username: userController.text,
                  email: emailController.text,
                  phoneNumber: numeroController.text,
                  password: contraController.text,
                );

                context.read<AccountProvider>().addAccount(nuevaCuenta);
                Navigator.pop(context); // Cierra el modal después de agregar la cuenta
              })
        ]),
      ),
    );
  }
}
