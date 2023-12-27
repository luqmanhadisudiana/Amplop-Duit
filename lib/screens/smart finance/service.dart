import 'package:amplop_duit/component/table/data/bulan_row_data.dart';
import 'package:amplop_duit/component/table/data/column_row_data.dart';
import 'package:amplop_duit/component/table/data/default_row_data.dart';
import 'package:amplop_duit/component/table/data/tanggal_row_data.dart';
import 'package:amplop_duit/models/finance.dart';
import 'package:amplop_duit/util/formated_text.dart';
import 'package:amplop_duit/util/sort_datetime.dart';
import 'package:flutter/material.dart';

const customPadding = EdgeInsets.only(left: 16, top: 8);

List<FinanceRowHelper> getRowMonthlyFinance(
    List<DailyFinance> dataDaily, List<MonthlyFinance> dataMonthly) {
  List<FinanceRowHelper> monthlyFinanceRow;

  Map<String, List<DailyFinance>> sortedMonth =
      groupByMonth(dataDaily, (finance) {
    String month = "${finance.datetime.month}".padLeft(2, '0');
    String year = "${finance.datetime.year}";
    return "$year-$month";
  }, ascending: false);

  if (sortedMonth.isEmpty) {
    return monthlyFinanceRow = [];
  } else {
    debugPrint('Map sortedMonth tidak kosong, ${sortedMonth.length}');
    monthlyFinanceRow = [];
    sortedMonth.forEach((month, finance) {
      int countTemp = 0;
      int tempIncome = 0;
      for (var data in finance) {
        if (data.status == "Uang Keluar") {
          countTemp -= data.nominal;
        } else {
          countTemp += data.nominal;
        }
      }

      for (var i = 0; i < dataMonthly.length; i++) {
        if (parseYearMonth(month).month == dataMonthly[i].datetime.month) {
          tempIncome = dataMonthly[i].nominal;
        }
      }

      monthlyFinanceRow.add(FinanceRowHelper(status: true, widgets: [
        BulanRowData(
          date: parseYearMonth(month),
          padding: customPadding,
        ),
        DefaultRowData(
          text: formatToMoneyText(tempIncome.toDouble()),
          padding: customPadding,
        ),
        ColumnRowData(
          topText: formatToMoneyText(countTemp.abs().toDouble()),
          bottomText:
              'total : ${formatToMoneyText((tempIncome - (-countTemp)).toDouble())}',
          padding: const EdgeInsets.only(right: 16, top: 8),
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
        ),
      ]));
    });
  }
  return monthlyFinanceRow;
}

List<FinanceRowHelper> getRowDailyFinance(List<DailyFinance> data) {
  List<DailyFinance> dailyFinances =
      sortByKey(data, (finance) => finance.datetime, descending: true);

  List<FinanceRowHelper> dailyFinancesRow;

  if (dailyFinances.isNotEmpty) {
    dailyFinancesRow = [
      for (var i = 0; i < dailyFinances.length; i++)
        FinanceRowHelper(
            status: i != dailyFinances.length - 1
                ? dailyFinances[i].datetime.month !=
                        dailyFinances[i + 1].datetime.month
                    ? true
                    : false
                : false,
            widgets: [
              TanggalRowData(
                date: dailyFinances[i].datetime,
                padding: customPadding,
              ),
              ColumnRowData(
                topText: dailyFinances[i].deskripsi,
                bottomText: "",
                version2: true,
                status: dailyFinances[i].status,
                padding: const EdgeInsets.only(left: 16, top: 8),
              ),
              DefaultRowData(
                text: formatToMoneyText(dailyFinances[i].nominal.toDouble()),
                fontSize: 10,
                alignment: Alignment.center,
                padding: customPadding,
              ),
            ])
    ];
  } else {
    return dailyFinancesRow = [];
  }

  return dailyFinancesRow;
}

// int getCurrentIncome() {
//   for (var i = 0; i < listMonthlyFinance.length; i++) {
//     if (DateTime.now().month == listMonthlyFinance[i].datetime.month) {
//       return listMonthlyFinance[i].nominal;
//     }
//   }

//   return 0;
// }
