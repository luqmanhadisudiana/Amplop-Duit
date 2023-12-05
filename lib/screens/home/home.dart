import 'package:amplop_duit/component/card/card_state.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 15.0),
          margin: const EdgeInsets.all(0.0),
          decoration: const BoxDecoration(color: Color(0xFF725CC8)),
          child: Column(children: [
            // Bagian Atas
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: <Widget>[
                    // profile photos
                    Container(
                      height: 42.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFFFFFFF),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/img/Bubu.png', // dummy photo
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16.0,
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Bubu Amdul",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Newbie",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ],
                ),
                const Row(
                  children: [
                    Icon(
                      Icons.circle,
                      color: Colors.amber,
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      "2805",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                )
              ],
            ),
            //Bagian Bawah
            Container(
              margin: const EdgeInsets.only(top: 25.0),
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(6.0))),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.favorite,
                            size: 60,
                            color: Colors.pink,
                          ),
                          SizedBox(width: 21.0),
                          Text(
                            "5",
                            style: TextStyle(
                                color: Color(0xFF3F3F3F),
                                fontSize: 32,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.diamond,
                            size: 60,
                            color: Colors.blue,
                          ),
                          SizedBox(width: 21.0),
                          Text(
                            "5",
                            style: TextStyle(
                                color: Color(0xFF3F3F3F),
                                fontSize: 32,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ]),
            )
          ]),
        ),
        // section 2
        Container(
          padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  // height: 130,
                  // width: double.infinity,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/img/home/Home-MyCourse.png'),
                        fit: BoxFit.cover,
                      ),
                      color: Colors.amber),
                  child: Center(
                    child: Text(
                      'HELLO WORLD PANJANG',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                // height: 130,
                // width: 160,

                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/img/home/Home-Level Kamu.png'),
                    fit: BoxFit.cover,
                  ),
                  color: Colors.amber,
                ),
                child: Center(
                  child: Text(
                    'HELLO WORLD PANJANG',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // section 3
        Container(
          padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 15.0),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "statistik",
                textAlign: TextAlign.left,
              ),
              // decoration: BoxDecoration(color: Colors.blue),
              SizedBox(
                height: 16.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CardState(
                      title: 'test',
                      value: 'test',
                      imageUrl: 'assets/img/home/Card-State-Day.png'),
                  SizedBox(width: 30),
                  CardState(
                      title: 'test',
                      value: 'test',
                      imageUrl: 'assets/img/home/Card-State-Total-Point.png'),
                ],
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CardState(
                      title: 'test',
                      value: 'test',
                      imageUrl: 'assets/img/home/Card-State-Countdown.png'),
                  SizedBox(width: 30),
                  CardState(
                      title: 'test',
                      value: 'test',
                      imageUrl: 'assets/img/home/Card-State-Position.png'),
                ],
              )
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 15.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Pencapaian"),
                for (var i = 0; i < 3; i++) Text((i + 15).toString())
              ]),
        ),
        Center(
          child: const Text("liat lainnya"),
        ),
      ],
    );
  }
}
