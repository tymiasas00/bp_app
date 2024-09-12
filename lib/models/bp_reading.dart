class BloodPressureReading{
  final int id;
  final int systolic;
  final int diastolic;
  final DateTime date;

  BloodPressureReading({
    required this.id,
    required this.systolic,
    required this.diastolic,
    required this.date});

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