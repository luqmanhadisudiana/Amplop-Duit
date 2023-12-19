import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CardThumbnail extends StatelessWidget {
  final String imageUrl;
  final bool isNetwork;

  const CardThumbnail(
      {super.key, required this.imageUrl, this.isNetwork = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Kotak di belakang
        Container(
            width: 140,
            height: 110,
            decoration: BoxDecoration(
              color: const Color(0xFFB0D8B0),
              borderRadius: const BorderRadius.all(Radius.circular(6.0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 10.0,
                  offset: const Offset(0, 4),
                  spreadRadius: 0,
                ),
              ],
            )),
        // Kotak di depan
        Positioned(
          child: Container(
            width: 140,
            height: 100,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: const BoxDecoration(
                color: Color(0xFF339933),
                borderRadius: BorderRadius.all(Radius.circular(6.0))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                isNetwork
                    ? Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        width: double.maxFinite,
                        height: 70,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return
                                // Container(
                                // padding: const EdgeInsets.only(top: 10),
                                // child: Column(
                                // children: [
                                Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                width: double.maxFinite,
                                height: 70,
                                color: Colors.white,
                              ),
                              // ),
                              // Center(
                              //   child: CircularProgressIndicator(
                              //     value: loadingProgress.expectedTotalBytes !=
                              //             null
                              //         ? loadingProgress
                              //                 .cumulativeBytesLoaded /
                              //             (loadingProgress
                              //                     .expectedTotalBytes ??
                              //                 1)
                              //         : null,
                              //   ),
                              // ),
                              // ],
                              // )
                            );
                          }
                        },
                        errorBuilder: (BuildContext context, Object error,
                            StackTrace? stackTrace) {
                          // Menampilkan widget pengganti ketika terjadi kesalahan
                          return Container(
                            alignment: Alignment.center,
                            width: 50.0,
                            height: 50.0,
                            color: Colors.red,
                            child: const Icon(Icons.error, color: Colors.white),
                          );
                        },
                      )
                    : Image.asset(
                        imageUrl,
                        fit: BoxFit.cover,
                      ),
                Container(
                  margin: const EdgeInsets.only(bottom: 6.0),
                  child: const Icon(
                    Icons.play_arrow,
                    size: 20,
                    color: Color(0xFFE6F2E6),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
