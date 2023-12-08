import 'package:amplop_duit/component/button/main_button.dart';
import 'package:flutter/material.dart';

class CustomBottomSheet extends StatelessWidget {
  final bool status;
  final Function? action;

  const CustomBottomSheet({Key? key, this.status = true, this.action})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 16),
      decoration: const BoxDecoration(
        color: Color(0xFF5338BC),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                status
                    ? const Icon(
                        Icons.check_circle_rounded,
                        color: Color(0xFF339933),
                        size: 56,
                      )
                    : const Icon(
                        Icons.cancel_rounded,
                        color: Color.fromARGB(255, 229, 28, 13),
                        size: 56,
                      ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        status ? "Kamu hebat!" : "Jawaban kamu belum tepat :",
                        style: const TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      Text(
                          status
                              ? "Jaga semangatmu agar menjadi nomor satu!"
                              : "Semangat, ayo simak kembali materi dan perbaiki jawabanmu",
                          style: const TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: Colors.white)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: MainButton(
                width: double.maxFinite,
                buttonText: "Selanjutnya",
                bgColor: Colors.white,
                textColor: const Color(0xFF725CC8),
                action: () {
                  debugPrint("Bottom modal click!");
                  if (action != null) {
                    action!();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

void showCustomBottomSheet(BuildContext context, bool status,
    [Function? action]) {
  showModalBottomSheet<void>(
    context: context,
    isDismissible: false,
    enableDrag: false,
    builder: (BuildContext context) {
      return CustomBottomSheet(
        status: status,
        action: action,
      );
    },
  );
}
