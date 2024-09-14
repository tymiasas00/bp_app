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

  Future<DateTime?> showDateTimePicker({
  required BuildContext context,
  DateTime? initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
}) async {
  initialDate ??= DateTime.now();
  firstDate ??= initialDate.subtract(const Duration(days: 365 * 100));
  lastDate ??= firstDate.add(const Duration(days: 365 * 200));

  final DateTime? selectedDate = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: firstDate,
    lastDate: lastDate,
  );

  if (selectedDate == null) return null;

  if (!context.mounted) return selectedDate;

  final TimeOfDay? selectedTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.fromDateTime(initialDate),
  );

  return selectedTime == null
      ? selectedDate
      : DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );
}


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDateTimePicker(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
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
                  mainAxisAlignment: MainAxisAlignment.end,
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
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () => _selectDate(context),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('Select date:'),
                          SizedBox(width: 16),
                          Icon(Icons.calendar_today),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
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
              ],
            ),
            const SizedBox(height: 80),
            Row(
              children: [
                ElevatedButton(
                  onPressed: buttonPressed,
                  child: const Text('Save'),
                ),
                ElevatedButton(
                  onPressed: ()=>Navigator.pop(context),
                  child: const Text("Cancel"),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}