import 'package:amplop_duit/util/formated_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardFinanceResult extends StatelessWidget {
  final Function? action;
  final double number;
  const CardFinanceResult({super.key, this.action, this.number = 0});

  @override
  Widget build(BuildContext context) {
    // Container Hasil
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 94,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            SvgPicture.asset(
              "assets/img/background/Smart Finance - Pemasukan Uang Bulanan Output.svg",
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            Container(
              padding: const EdgeInsets.only(
                  left: 16, bottom: 16, right: 16, top: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Pemasukan Bulanan",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Poppins")),
                      Container(
                        padding: const EdgeInsets.all(5),
                        child: InkWell(
                          onTap: () {
                            debugPrint("Ubah Pemasukan");
                            if (action != null) {
                              action!();
                            }
                            // changeTempNumber(0);
                            // tempController.text = '';
                          },
                          child: const Text("Ubah pemasukan",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Poppins")),
                        ),
                      ),
                    ],
                  ),
                  Text(formatToMoneyText(number),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Poppins")),
                ],
              ),
            ),
          ],
        ));
  }
}
