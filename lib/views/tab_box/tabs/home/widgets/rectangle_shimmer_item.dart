import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class RectangleShimmerItem extends StatelessWidget {
  const RectangleShimmerItem({
    super.key,
    this.width = 0,
    this.height = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
      ),
    );
  }

  final double? width;
  final double? height;
}
