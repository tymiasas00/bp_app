
class BloodPressureReading{
  final String id;
  final int systolic;
  final int diastolic;
  final int pulse;
  final DateTime date;
  final String notes;
  

  BloodPressureReading({
    required this.id,
    required this.systolic,
    required this.diastolic,
    required this.date,
    required this.pulse,
    this.notes = '',
    });


  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'systolic': systolic,
      'diastolic': diastolic,
      'pulse': pulse,
      'date': date.toIso8601String(),
      'notes': notes
    };
  }

  @override
  String toString() {
    return 'BloodPressureReading{id: $id, systolic: $systolic, diastolic: $diastolic, date: $date}';
  }
}