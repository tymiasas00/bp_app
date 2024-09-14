import 'package:uuid/uuid.dart';

class BloodPressureReading{
  final String id;
  final int systolic;
  final int diastolic;
  final int pulse;
  final DateTime date;
  

  BloodPressureReading({
    required this.systolic,
    required this.diastolic,
    required this.date,
    required this.pulse,
    }) : id = const Uuid().v1();


  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'systolic': systolic,
      'diastolic': diastolic,
      'date': date.toIso8601String()
    };
  }

  @override
  String toString() {
    return 'BloodPressureReading{id: $id, systolic: $systolic, diastolic: $diastolic, date: $date}';
  }
}