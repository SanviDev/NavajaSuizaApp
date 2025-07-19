import 'package:flutter/material.dart';

class NutritionPage extends StatelessWidget {
  const NutritionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF232332),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.blue,
        elevation: 0,
        title: const Text('Nutrition Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to the Nutrition Page!',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add your button action here
              },
              child: const Text('Start Nutrition'),
            ),
          ],
        ),
      ),
    );
  }
}
