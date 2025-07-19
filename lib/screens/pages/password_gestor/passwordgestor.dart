import 'package:flutter/material.dart';
import 'package:navaja_suiza/providers/account-provider.dart';
import 'package:navaja_suiza/screens/pages/password_gestor/signin.dart';
import 'package:navaja_suiza/screens/pages/password_gestor/signup.dart';
import 'package:provider/provider.dart';

class PasswordGestor extends StatefulWidget {
  const PasswordGestor({Key? key}) : super(key: key);

  @override
  State<PasswordGestor> createState() => _PasswordGestorState();
}

class _PasswordGestorState extends State<PasswordGestor> {
  Future<void> verificarCuenta() async {
    final tieneCuenta = await context.read<AccountProvider>().register();

    if (!mounted) return; // Evita error si el widget fue desmontado

    if (tieneCuenta) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => SignInPG()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => SignUpPG()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF232343),
      appBar: AppBar(
        title: const Text('Gestor de Contraseñas'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding:
                const EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          onPressed: verificarCuenta,
          child: const Text('Entrar al Gestor de Cuentas', style: TextStyle(color: Colors.black, fontSize: 16.0)),
        ),
      ),
    );
  }
}
