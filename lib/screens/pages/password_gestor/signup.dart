import 'package:flutter/material.dart';
import 'package:navaja_suiza/providers/account-provider.dart';
import 'package:provider/provider.dart';


class SignUpPG extends StatelessWidget {

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF232343),

      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Registro de Gestor de Contraseñas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              Text('Registra una contraseña para comenzar', style: TextStyle(fontSize: 18, color: Colors.white)),
              SizedBox(height: 20),
              Text('Usaras esta contraseña para acceder a tus cuentas', style: TextStyle(color: Colors.white)),
              SizedBox(height: 20),
              TextField(
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
              TextField(
                controller: confirmPasswordController,
                onChanged: (value) {
                  context.read<AccountProvider>().setPassword(value);
                },
                decoration: InputDecoration(
                  labelText: 'Confirmar Contraseña',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 50),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32.0, vertical: 12.0),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () {
                  if(passwordController.text.isNotEmpty &&
                     confirmPasswordController.text.isNotEmpty &&
                     passwordController.text == confirmPasswordController.text) {
                      Provider.of<AccountProvider>(context, listen: false)
                        .savePassword(passwordController.text);
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Las contraseñas no coinciden o están vacías'))
                    );
                  }
                },
                child: const Text('Registrar contraseña', style: TextStyle(color: Colors.black, fontSize: 16.0)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
