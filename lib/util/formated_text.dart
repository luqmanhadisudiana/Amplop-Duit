import 'package:intl/intl.dart';

String formatToMoneyText(int number) {
  return NumberFormat('Rp #,##0.00', 'id_ID').format(number);
}
