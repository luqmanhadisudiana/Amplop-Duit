import 'package:flutter/material.dart';

class CardThumbnail extends StatelessWidget {
  final String imageUrl;

  const CardThumbnail({super.key, required this.imageUrl});

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
                Image.asset(
                  // "assets/img/thumbnail/Thumbnail Amplop Duit Ep 1.png",
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
