import 'package:book_store/presentation/utils/my_icons.dart';
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
            height: 100.h,
          )
        : CircleAvatar(
            radius: 50.r,
            backgroundImage: CachedNetworkImageProvider(photoURL!),
            backgroundColor: Colors.grey.shade300,
          );
  }

  final String? photoURL;
}
