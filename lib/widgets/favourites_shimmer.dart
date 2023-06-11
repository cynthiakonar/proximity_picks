import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FavouritesShimmer extends StatelessWidget {
  const FavouritesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: Wrap(
        children: [
          "testing",
          "testing",
          "testiiing",
          "test",
          "testing",
          "testinggg"
        ].map((tag) {
          return Container(
            margin: const EdgeInsets.only(right: 8, top: 12),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                border: Border.all(
                  width: 1,
                  color: Colors.grey,
                )),
            child: Text(
              tag,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
