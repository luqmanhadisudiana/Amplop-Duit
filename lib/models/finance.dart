class Finance {
  final String deskripsi, status;
  final int nominal;
  final DateTime datetime;

  const Finance({
    this.status = "Uang Masuk",
    required this.deskripsi,
    required this.datetime,
    required this.nominal,
  });
}

// List<Finance> listFinance = [];
List<Finance> listFinance = [
  Finance(deskripsi: "test 1", datetime: DateTime.now(), nominal: 3000),
  Finance(
      deskripsi: "test 4",
      datetime: DateTime(
          DateTime.now().year, DateTime.now().month - 1, DateTime.now().day),
      nominal: 3000),
  Finance(
      deskripsi: "test 6",
      datetime: DateTime(DateTime.now().year, DateTime.now().month - 3,
          DateTime.now().day - 4),
      nominal: 3000),
  Finance(
      deskripsi: "test 5",
      datetime: DateTime(DateTime.now().year, DateTime.now().month - 1,
          DateTime.now().day - 3),
      nominal: 3000),
  Finance(
      deskripsi: "test 2",
      datetime: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day - 2),
      nominal: 3000),
  Finance(
      deskripsi: "test 3",
      datetime: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day - 7),
      nominal: 3000),
];
