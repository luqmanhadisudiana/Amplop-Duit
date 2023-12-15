import 'package:intl/intl.dart';

String formatToMoneyText(double number) {
  return NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 2)
      .format(number);
}
