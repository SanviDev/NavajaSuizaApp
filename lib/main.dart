import 'package:flutter/material.dart';
import 'package:navaja_suiza/providers/account-provider.dart';
import 'package:navaja_suiza/providers/task-provider.dart';
import 'package:navaja_suiza/screens/principalhome.dart';
import 'package:navaja_suiza/providers/gym-provider.dart';
import 'package:provider/provider.dart';





  void main() async {
    WidgetsFlutterBinding.ensureInitialized();

      // Detecta zona horaria del dispositivo y la configura como local

    runApp(const MyApp());
  }

  class MyApp extends StatelessWidget {
    const MyApp({super.key});

    // This widget is the root of your application.
    @override
    Widget build(BuildContext context) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => GymProvider()),
          ChangeNotifierProvider(create: (_) => TareaProvider()),
          ChangeNotifierProvider(create: (_) => AccountProvider())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Navaja Suiza App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const Home(key: Key('home')),
        ),
      );
    }
  }

  class Home extends StatelessWidget {
    const Home({super.key});

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: const Color(0xFF232332),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('Navaja Suiza App',
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
                SizedBox(width: 8),
                Icon(Icons.handyman, color: Colors.white),
              ]),
              SizedBox(height: 8),
              Text('Todas tus herramientas en una sola app',
                  style: TextStyle(color: Colors.white)),
              SizedBox(height: 32),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  textStyle: TextStyle(fontSize: 16),
                  fixedSize: Size(200, 50),
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PrincipalHome(
                          key: Key('principal_home'),
                        ),
                      ));
                },
                child: Text('Entrar', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      );
    }
  }
