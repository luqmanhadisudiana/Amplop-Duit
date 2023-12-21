class History {
  final int idCourse, attempt;
  final String title, question, jawaban;
  final bool status;

  const History(
      {required this.idCourse,
      required this.status,
      required this.attempt,
      required this.title,
      required this.question,
      required this.jawaban});
}

List<History> listHistory = [];
