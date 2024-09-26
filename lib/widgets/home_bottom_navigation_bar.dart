import 'package:bp_app/screens/add_reading_screen.dart';
import 'package:bp_app/models/bp_reading.dart';
import 'package:flutter/material.dart';

class HomeBottomNavigationBar extends StatelessWidget {
  final void Function(BloodPressureReading reading) onSaveReading;

  const HomeBottomNavigationBar({
    super.key,
    required this.onSaveReading,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'Add',
          
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
      onTap: (int index) {
        if (index == 0) {} 
        else if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (ctx){return AddReadingScreen(onSaveReading: onSaveReading);}),
          );
        } else if (index == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (ctx){return const Placeholder();}),
          );
        }
      },
    );
  }
}
