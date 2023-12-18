Map<String, List<T>> groupByMonth<T>(List<T> list, String Function(T) getMonth,
    {bool ascending = true}) {
  Map<String, List<T>> result = {};

  // Menggunakan List.from untuk membuat salinan daftar dan mempertahankan urutan asli
  List<T> sortedList = List.from(list);

  // Mengurutkan daftar berdasarkan nilai bulan
  sortedList.sort((a, b) {
    String monthA = getMonth(a);
    String monthB = getMonth(b);

    // Menggunakan compareTo untuk membandingkan string bulan
    int comparison = monthA.compareTo(monthB);

    // Mengganti nilai comparison berdasarkan arah pengurutan
    return ascending ? comparison : -comparison;
  });

  // Mengelompokkan objek-objek yang telah diurutkan
  for (var item in sortedList) {
    String monthKey = getMonth(item);
    result[monthKey] ??= [];
    result[monthKey]!.add(item);
  }

  return result;
}

DateTime parseYearMonth(String yearMonthString) {
  List<String> parts = yearMonthString.split('-');
  if (parts.length == 2) {
    int year = int.tryParse(parts[0]) ?? 0;
    int month = int.tryParse(parts[1]) ?? 1;
    return DateTime(year, month);
  } else {
    // invalid format goes ten years later
    return DateTime.now().add(const Duration(days: 365 * 10));
  }
}

// String getMonthFromDate(DateTime dateTime) {
//   return "${dateTime.month}";
// }

List<T> sortByKey<T, K extends Comparable<K>>(
    List<T> list, K Function(T) getKey,
    {bool descending = false}) {
  list.sort((a, b) {
    final keyA = getKey(a);
    final keyB = getKey(b);

    // Gunakan descending untuk menentukan arah pengurutan
    final comparison = keyA.compareTo(keyB);
    return descending ? -comparison : comparison;
  });

  return list;
}
