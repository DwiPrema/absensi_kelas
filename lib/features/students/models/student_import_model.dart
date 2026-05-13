class StudentImportModel {
  final String name;
  final String rollNum;
  final String nis;
  final String nisn;
  final String gender;

  StudentImportModel({
    required this.name,
    required this.rollNum,
    required this.nis,
    required this.nisn,
    required this.gender,
  });

  factory StudentImportModel.fromJson(Map<String, dynamic> json) {
    return StudentImportModel(
      name: json['name'] ?? '',
      rollNum: json['rollNum'] ?? '',
      nis: json['nis'] ?? '-',
      nisn: json['nisn'] ?? '-',
      gender: json['gender'] ?? '-',
    );
  }
}
