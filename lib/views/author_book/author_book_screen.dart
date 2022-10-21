import 'package:book_store/constants/route_names.dart';
import 'package:book_store/data/models/author/author_model.dart';
import 'package:book_store/data/models/book/book_model.dart';
import 'package:book_store/providers/book_provider.dart';
import 'package:book_store/utils/my_colors.dart';
import 'package:book_store/utils/my_fonts.dart';
import 'package:book_store/utils/my_icons.dart';
import 'package:book_store/views/author_book/widgets/book_info_item.dart';
import 'package:book_store/views/home/widgets/rectangle_shimmer_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class AuhtorBookScreen extends StatefulWidget {
  const AuhtorBookScreen({
    required this.author,
    super.key,
  });

  @override
  State<AuhtorBookScreen> createState() => _AuhtorBookScreenState();

  final AuthorModel author;
}

class _AuhtorBookScreenState extends State<AuhtorBookScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<BookModel>>(
      stream: context
          .read<BookProvider>()
          .getBooksByAuhtorId(authorId: widget.author.id),
      initialData: null,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            backgroundColor: MyColors.white,
            body: SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: MyColors.white,
                    leading: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: SvgPicture.asset(
                        MyIcons.arrowBackIcon,
                        color: MyColors.black,
                      ),
                    ),
                    elevation: 0.0,
                    expandedHeight: 200,
                    title: Text(
                      widget.author.authorFullName,
                      style: MyFonts.w600.copyWith(
                        fontSize: 20.sp,
                      ),
                    ),
                    pinned: true,
                    centerTitle: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Padding(
                        padding: EdgeInsets.only(top: 50.h),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: CachedNetworkImage(
                                  imageUrl: widget.author.authorImg,
                                  height: 100,
                                  placeholder: (context, url) {
                                    return const RectangleShimmerItem(
                                      height: 100,
                                      width: 100,
                                    );
                                  }),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              "${snapshot.data!.length} books",
                              style: MyFonts.w400.copyWith(
                                fontSize: 13.sp,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          BookModel bookItem = snapshot.data![index];
                          return BookInfoItem(
                            bookItem: bookItem,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                RouteNames.bookDetail,
                                arguments: bookItem.id,
                              );
                            },
                          );
                        },
                        childCount: snapshot.data!.length,
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 25,
                        childAspectRatio: 0.55,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
