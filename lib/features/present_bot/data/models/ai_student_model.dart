///MODEL UNTUK RESPONSE DARI GOOGLE AI
class AIStudentModel {
  final String studentName;
  final int rollNum;
  final String? nis;
  final String? nisn;

  const AIStudentModel({
    required this.studentName,
    required this.rollNum,
    this.nis,
    this.nisn,
  });

  factory AIStudentModel.fromJson(Map<String, dynamic> json) {
    return AIStudentModel(
        studentName: json["name"],
        rollNum: json["rollNum"],
        nis: json["nis"],
        nisn: json["nisn"]);
  }
}
