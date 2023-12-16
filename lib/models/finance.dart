class Finance {
  final String deskripsi, status;
  final int nominal;
  final DateTime datetime;

  const Finance({
    required this.status,
    required this.deskripsi,
    required this.datetime,
    required this.nominal,
  });
}

List<Finance> listFinance = [];
