import 'package:book_store/utils/my_icons.dart';
import 'package:book_store/presentation/views/tab_box/tabs/home/widgets/rectangle_shimmer_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileImgItem extends StatelessWidget {
  const ProfileImgItem({super.key, this.photoURL});

  @override
  Widget build(BuildContext context) {
    return photoURL == null
        ? Image.asset(
            MyIcons.profileDefaultImg,
            height: 100,
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(50.r),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: photoURL!,
              height: 100.h,
              width: 90.w,
              placeholder: (context, url) {
                return RectangleShimmerItem(
                  height: 100.h,
                  width: 90.w,
                  radius: 50.r,
                );
              },
            ),
          );
  }

  final String? photoURL;
}
