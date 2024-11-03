import 'package:flutter/material.dart';
import 'package:bp_app/database/database_helper.dart';
import 'package:bp_app/widgets/bp_reading_cart.dart';
import 'package:bp_app/widgets/home_bottom_navigation_bar.dart';
import 'package:bp_app/models/bp_reading.dart';
import 'package:sqflite/sqflite.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<BloodPressureReading>> _readingsFuture;

  @override
  void initState() {
    super.initState();
    _loadReadings();
  }

  void _loadReadings() {
    _readingsFuture = DatabaseHelper().getReadings();
  }

  void _addReading(BloodPressureReading reading) {
    setState(() {
      DatabaseHelper().insertReading(reading);
      _readingsFuture = DatabaseHelper().getReadings();
    });
  }
  void _deleteReading(BloodPressureReading reading){
    setState(() {
      DatabaseHelper().deleteReading(reading.id);
      _readingsFuture = DatabaseHelper().getReadings();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blood Pressure Tracker'),
      ),
      bottomNavigationBar: HomeBottomNavigationBar(
        onSaveReading: _addReading,
      ),
      body: FutureBuilder<List<BloodPressureReading>>(
        future: _readingsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No readings found.'));
          } else {
            final readings = snapshot.data!;
            return ListView.builder(
              itemCount: readings.length,
              itemBuilder: (context, index) {
                final reading = readings[index];
                return Dismissible(
                  key: ValueKey(reading.id),
                  child: ReadingCard(reading: reading),
                  onDismissed: (direction) {
                    setState(() {
                      _deleteReading(reading);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Reading deleted'),
                        action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () {
                            setState(() {
                              _addReading(reading);
                            });
                          },
                        ),
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
