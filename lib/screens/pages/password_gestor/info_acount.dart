import 'package:flutter/material.dart';
import 'package:navaja_suiza/models/accountModel.dart';

class AccountInfo extends StatefulWidget {
  final Account account;
  const AccountInfo({super.key, required this.account});

  @override
  State<AccountInfo> createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  late final Account account;

  @override
  void initState() {
    super.initState();
    account = widget.account;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff131331),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Cuenta ${account.appName}'),
      ),
      body: Column(
        children: [
          SizedBox(height: 32,),
          Text('Nombre de usuario: ${account.username!.isEmpty ? 'No aplica' : account.username}', style: TextStyle(color: Colors.white, fontSize: 16),),
          SizedBox(height: 8),
          Text('Contraseña: ${account.password!.isEmpty ? 'No Aplica' : account.password}',  style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          SizedBox(height: 8),
          Text('Correo electrónico: ${account.email!.isEmpty ? 'No aplica' : account.email}',  style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          SizedBox(height: 8),
          Text('Notas: ${account.phoneNumber!.isEmpty ? 'No aplica' : account.phoneNumber}',  style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          SizedBox(height: 32),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                textStyle: TextStyle(fontSize: 16),
                shadowColor: Colors.black54,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                // Acción al presionar el botón
              },
              child: Text('Editar cuenta', style: TextStyle(color: Colors.white),),
            ),
          ),
          SizedBox(height: 8),
          Center(
            child: ElevatedButton( 
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                textStyle: TextStyle(fontSize: 16),
                shadowColor: Colors.black54,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                // Acción al presionar el botón
              },
              child: Text('Eliminar cuenta', style: TextStyle(color: Colors.white),),
            ),
          ),
          ],
      ),
    );
  }
}
