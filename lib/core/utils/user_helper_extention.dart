extension PatientNameExtractor on String {
  List<String> get patientNameParts => split(' ');

  String get firstName =>
      patientNameParts.isNotEmpty ? patientNameParts[0] : '';

  String get middleName =>
      patientNameParts.length >= 2 ? patientNameParts[1] : '';

  String get familyName =>
      patientNameParts.length >= 3 ? patientNameParts.sublist(2).join(' ') : '';
}
