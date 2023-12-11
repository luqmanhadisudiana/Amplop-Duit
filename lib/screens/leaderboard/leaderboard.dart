import 'package:flutter/material.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              children: [
                const Row(
                  children: [Text("test")],
                ),
                const Text(
                  "Liga Perunggu",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Poppins"),
                ),
                const Text(
                  "Peringkat berdasarkan daerah tinggalmu,  3 teratas akan maju ke liga berikutnya",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Poppins"),
                ),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(15.0),
                          topLeft: Radius.circular(15.0),
                        ),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("test"),
                          Row(
                            children: [Text("test"), Text("test")],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(15.0),
                          bottomRight: Radius.circular(15.0),
                        ),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("test"),
                          Row(
                            children: [Text("test"), Text("test")],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Test $index"),
                          Text("Test $index"),
                          Text("Test $index"),
                          Text("Test $index"),
                        ]),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
