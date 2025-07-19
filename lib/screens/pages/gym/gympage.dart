import 'package:flutter/material.dart';
import 'package:navaja_suiza/modules/list/routinelist.dart';
import 'package:navaja_suiza/modules/new/newroutine.dart';

class GymPage extends StatelessWidget {

  const GymPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rutinas de Gimnasio'),
        backgroundColor: Colors.blue,
      ),
      body: const StrengthRoutinePage(),

      backgroundColor: const Color(0xff121221),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            backgroundColor: Colors.blueGrey[900],
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
            builder: (context) {
            return NewRoutine();
          });
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
