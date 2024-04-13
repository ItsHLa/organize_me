class Medicien {
  final int id;
  final String name;

  final String numberOfDose;
  final String reminder;
  final String timeOfMedicien;

  Medicien(
      {required this.name,
      required this.numberOfDose,
      required this.reminder,
      required this.timeOfMedicien,
      required this.id});
}
