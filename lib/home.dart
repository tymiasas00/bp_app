import 'package:bp_app/home_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blood pressure tracker'),
      ),
      // write bottom navigation bar with three buttons with icons as well as labels
      bottomNavigationBar: const HomeBottomNavigationBar(),
    );
  }
}
