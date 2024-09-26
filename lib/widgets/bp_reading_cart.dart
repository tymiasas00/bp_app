import 'package:flutter/material.dart';
import 'package:bp_app/models/bp_reading.dart';
import 'package:intl/intl.dart';

class ReadingCard extends StatelessWidget {
  final BloodPressureReading reading;

  const ReadingCard({required this.reading, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Systolic: ${reading.systolic} mmHg',
                style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              Icon(
                reading.systolic > 140 ? Icons.arrow_upward : Icons.arrow_downward,
                color: reading.systolic > 140 ? Colors.red : Colors.green,
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Diastolic: ${reading.diastolic} mmHg',
                style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              Icon(
                reading.diastolic > 90 ? Icons.arrow_upward : Icons.arrow_downward,
                color: reading.diastolic > 90 ? Colors.red : Colors.green,
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Pulse: ${reading.pulse} bpm',
                style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              Icon(
                reading.pulse > 100 ? Icons.arrow_upward : Icons.arrow_downward,
                color: reading.pulse > 100 ? Colors.red : Colors.green,
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text('${DateFormat.yMMMd().format(reading.date)} ${DateFormat.jm().format(reading.date)}'),
          const SizedBox(height: 8.0),
          Text(reading.notes != '' ? reading.notes : 'No notes'),
        ],
      ),
    );
  }
}
