import 'package:flutter/material.dart';
import 'pages/gym/gympage.dart';
import 'pages/tasks/taskpage.dart';
import 'pages/password_gestor/passwordgestor.dart';
import 'pages/nutrition/nutritionpage.dart';
import 'pages/goals/goalspage.dart';

class PrincipalHome extends StatefulWidget {
  const PrincipalHome({super.key});

  @override
  State<PrincipalHome> createState() => _PrincipalHomeState();
}

class _PrincipalHomeState extends State<PrincipalHome> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    GymPage(),
    TasksPage(),
    PasswordGestor(),
    NutritionPage(),
    GoalsPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: const Color(0xFF232332),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Gimnasio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task),
            label: 'Tareas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.key),
            label: 'Contraseñas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank),
            label: 'Alimentación',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flag),
            label: 'Objetivos',
          ),
        ],
      ),
    );
  }
}
