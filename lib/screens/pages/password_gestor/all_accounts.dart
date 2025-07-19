import 'package:flutter/material.dart';
import 'package:navaja_suiza/modules/new/newaccount.dart';
import 'package:navaja_suiza/providers/account-provider.dart';
import 'package:navaja_suiza/screens/pages/password_gestor/info_acount.dart';
import 'package:provider/provider.dart';

class AllAccounts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff131331),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Todas las Cuentas',
          style: TextStyle(color: Colors.black),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              backgroundColor: Color(0xff232323),
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return Newaccount();
              });
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
      body: Consumer<AccountProvider>(
        builder: (context, accountProvider, child) {
          final accounts = accountProvider.accounts;
          if (accounts.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No hay cuentas registradas',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Agrega una cuenta para comenzar',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            );
          } else {
            return ListView.builder(
              itemCount: accounts.length,
              itemBuilder: (context, index) {
              final account = accounts[index];
                return Card(
                  
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Color(0xff1a1a4b),
                  margin: EdgeInsets.all(8),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AccountInfo(account: account))
                        );
                    },
                    child: Container(
                      height: 90,
                      child: Center(
                          child: Text(account.appName,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18))),
                                  
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

