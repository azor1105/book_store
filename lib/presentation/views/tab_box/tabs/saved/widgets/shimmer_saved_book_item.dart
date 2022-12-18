import 'package:book_store/presentation/widgets/shimmers/rectangle_shimmer_item.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../utils/my_colors.dart';

class ShimmerSavedBookItem extends StatelessWidget {
  const ShimmerSavedBookItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: 140,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(width: 3, color: MyColors.blackWithOpacity087),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              Container(
                height: 110,
                width: 90,
                decoration: BoxDecoration(
                    color: MyColors.white,
                    borderRadius: BorderRadius.circular(13)),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const RectangleShimmerItem(width: 110, height: 14),
                    const SizedBox(
                      height: 10,
                    ),
                    const RectangleShimmerItem(width: 115, height: 12),
                    const Expanded(child: SizedBox()),
                    Row(
                      children: const [
                        RectangleShimmerItem(width: 80, height: 14),
                        Expanded(child: SizedBox()),
                        RectangleShimmerItem(width: 24, height: 24),
                        SizedBox(width: 10),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
