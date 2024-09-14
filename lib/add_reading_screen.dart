import 'package:bp_app/models/bp_reading.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class AddReadingScreen extends StatefulWidget {
  final void Function(BloodPressureReading reading) onSaveReading;
  const AddReadingScreen({
    super.key,
    required this.onSaveReading,
    });

  @override
  State<AddReadingScreen> createState() => _AddReadingScreenState();
}

class _AddReadingScreenState extends State<AddReadingScreen> {
  int systolicValue = 120;
  int diastolicValue = 80;
  int pulseValue = 90;
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
  void buttonPressed() {
    final reading = BloodPressureReading(
      systolic: systolicValue,
      diastolic: diastolicValue,
      date: selectedDate,
      pulse: pulseValue,
    );
    widget.onSaveReading(reading);
    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Reading'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Systolic'),
                NumberPicker(
                  value: systolicValue,
                  minValue: 0,
                  maxValue: 300,
                  onChanged: (value) {
                    setState(() {
                      systolicValue = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Diastolic'),
                NumberPicker(
                  value: diastolicValue,
                  minValue: 0,
                  maxValue: 200,
                  onChanged: (value) {
                    setState(() {
                      diastolicValue = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Pulse'),
                NumberPicker(
                  value: pulseValue,
                  minValue: 0,
                  maxValue: 200,
                  onChanged: (value) {
                    setState(() {
                      pulseValue = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Date'),
                TextButton(
                  onPressed: () => _selectDate(context),
                  child: Text(
                    '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: buttonPressed,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}