import 'package:book_store/utils/my_icons.dart';
import 'package:book_store/views/home/widgets/rectangle_shimmer_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
            borderRadius: BorderRadius.circular(50),
            child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: photoURL!,
                height: 100,
                width: 100,
                placeholder: (context, url) {
                  return const RectangleShimmerItem();
                }),
          );
  }

  final String? photoURL;
}
