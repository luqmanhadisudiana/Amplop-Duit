import 'package:amplop_duit/component/button/main_button.dart';
import 'package:amplop_duit/component/input/input_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardFinanceInput extends StatelessWidget {
  final Function? action;
  final TextEditingController? controller;
  const CardFinanceInput({super.key, this.action, this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 105,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            SvgPicture.asset(
              "assets/img/background/Smart Finance - Pemasukan Uang Bulanan 1.svg",
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Pemasukan uang bulanan",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Poppins")),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: MyTextField(
                        controller: controller,
                        textInputType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        hintText: "",
                        height: 32,
                        borderRadius: 6,
                        textStyle: const TextStyle(
                            fontSize: 12,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400),
                      )),
                      const SizedBox(
                        width: 16,
                      ),
                      MainButton(
                        buttonText: "Hitung",
                        bgColor: const Color(0xFFFF6E30),
                        padding: const EdgeInsets.all(0),
                        height: 32,
                        width: 80,
                        fontSize: 12,
                        borderRadius: 6,
                        action: () {
                          debugPrint("Change number");
                          if (action != null) {
                            action!();
                          }
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
