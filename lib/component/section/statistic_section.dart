import 'package:amplop_duit/component/card/card_state.dart';
import 'package:flutter/material.dart';

class StatisticSection extends StatelessWidget {
  const StatisticSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 15.0, left: 15.0, top: 15.0),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Statistik',
            style: TextStyle(
                // backgroundColor: Colors.black12,
                // color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.w600),
          ),
          // decoration: BoxDecoration(color: Colors.blue),
          SizedBox(
            height: 16.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CardState(
                  title: 'Runtutan Harian',
                  value: '5 Hari',
                  imageUrl: 'assets/img/home/Card-State-Day.png'),
              SizedBox(width: 30),
              CardState(
                  title: 'Total Poin',
                  value: '2805',
                  imageUrl: 'assets/img/home/Card-State-Total-Point.png'),
            ],
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CardState(
                  title: 'Sisa Waktu',
                  value: '2 Hari',
                  imageUrl: 'assets/img/home/Card-State-Countdown.png'),
              SizedBox(width: 30),
              CardState(
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
