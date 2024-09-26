import 'package:bp_app/widgets/bp_reading_cart.dart';
import 'package:bp_app/widgets/home_bottom_navigation_bar.dart';
import 'package:bp_app/models/bp_reading.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<BloodPressureReading> _readings = [];

  void _addReading(BloodPressureReading reading) {
    setState(() {
      _readings.add(reading);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Blood pressure tracker'),
        ),
        bottomNavigationBar: HomeBottomNavigationBar(
          onSaveReading: _addReading,
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: _readings.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                        key: ValueKey(_readings[index].id),
                        child: ReadingCard(reading: _readings[index]),
                        onDismissed: (direction) {
                          final deletedItem = _readings[index];
                          setState(() {
                            _readings.removeAt(index);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('Reading deleted'),
                              action: SnackBarAction(
                                label: 'Undo',
                                onPressed: () {
                                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                  setState(() {
                                    _readings.insert(index, deletedItem);
                                  });
                                },
                              ),
                            ),
                          );
                        });
                  }),
            ),
          ],
        ));
  }
}