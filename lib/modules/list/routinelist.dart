import 'package:flutter/material.dart';
import 'package:navaja_suiza/providers/gym-provider.dart';
import 'package:navaja_suiza/screens/pages/gym/routine_page.dart';
import 'package:provider/provider.dart';

class StrengthRoutinePage extends StatefulWidget {
  const StrengthRoutinePage({Key? key}) : super(key: key);

  @override
  State<StrengthRoutinePage> createState() => _StrengthRoutinePageState();
}

class _StrengthRoutinePageState extends State<StrengthRoutinePage> {
  late Future<void> _rutinasFuture;

  @override
  void initState() {
    super.initState();
    _rutinasFuture =
        Provider.of<GymProvider>(context, listen: false).loadRutinas();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: FutureBuilder(
        future: _rutinasFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Consumer<GymProvider>(
              builder: (context, gymProvider, child) {
                final routines = gymProvider.rutinas;

                if (routines.isEmpty) {
                  return const Center(
                      child: Text('Agrega tu primer rutina.',
                          style: TextStyle(color: Colors.white, fontSize: 18)));
                }

                return ListView.builder(
                  itemCount: routines.length,
                  itemBuilder: (context, index) {
                    final rutina = routines[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),

                      elevation: 4,
                      color: const Color(0xFF232343),
                      shadowColor: Colors.black54,
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16.0),
                        leading: Icon(Icons.fitness_center, color: Colors.white),
                        title: Text(rutina.name, style: TextStyle(color: Colors.white)),
                        subtitle: Text(rutina.description, style: TextStyle(color: Colors.white70)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RoutinePage(routine: rutina),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
