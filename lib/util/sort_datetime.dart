Map<String, List<T>> groupByMonth<T>(
    List<T> list, String Function(T) getMonth) {
  Map<String, List<T>> result = {};

  for (var item in list) {
    String monthKey = getMonth(item);
    result[monthKey] ??= [];
    result[monthKey]!.add(item);
  }

  return result;
}

List<T> sortByKey<T, K extends Comparable<K>>(
    List<T> list, K Function(T) getKey) {
  list.sort((a, b) {
    final keyA = getKey(a);
    final keyB = getKey(b);

    return keyA.compareTo(keyB);
  });

  return list;
}
