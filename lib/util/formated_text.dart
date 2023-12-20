import 'package:intl/intl.dart';

String formatToMoneyText(double number, {int decimal = 2}) {
  return NumberFormat.currency(
          locale: 'id_ID', symbol: 'Rp ', decimalDigits: decimal)
      .format(number);
}
