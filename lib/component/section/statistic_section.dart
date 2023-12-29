import 'package:amplop_duit/component/card/card_state.dart';
import 'package:flutter/material.dart';

class StatisticSection extends StatelessWidget {
  final String totalPoint;
  const StatisticSection({super.key, this.totalPoint = "2805"});

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    int hariBerlalu = today.weekday;
    int hariTersisa = 7 - hariBerlalu;

    String sHariBerlalu = '$hariBerlalu hari';
    String sHariTersisa = '$hariTersisa hari';

    return Container(
      padding: const EdgeInsets.only(right: 15.0, left: 15.0, top: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Statistik',
            style: TextStyle(
                // backgroundColor: Colors.black12,
                // color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.w600),
          ),
          // decoration: BoxDecoration(color: Colors.blue),
          const SizedBox(
            height: 15.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CardState(
                  title: 'Runtutan Harian',
                  value: sHariBerlalu,
                  imageUrl: 'assets/img/home/Card-State-Day.png'),
              const SizedBox(width: 15),
              CardState(
                  title: 'Total Poin',
                  value: totalPoint,
                  imageUrl: 'assets/img/home/Card-State-Total-Point.png'),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CardState(
                  title: 'Sisa Waktu',
                  value: sHariTersisa,
                  imageUrl: 'assets/img/home/Card-State-Countdown.png'),
              const SizedBox(width: 15),
              const CardState(
                  title: 'Posisi Tertinggi',
                  value: '2',
                  imageUrl: 'assets/img/home/Card-State-Position.png'),
            ],
          )
        ],
      ),
    );
  }
}
