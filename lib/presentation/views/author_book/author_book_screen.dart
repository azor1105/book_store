import 'package:book_store/cubits/book/book_cubit.dart';
import 'package:book_store/data/models/status.dart';
import 'package:book_store/presentation/utils/constants/route_names.dart';
import 'package:book_store/data/models/author/author_model.dart';
import 'package:book_store/data/models/book/book_model.dart';
import 'package:book_store/presentation/widgets/shimmers/circle_shimmer_item.dart';
import 'package:book_store/presentation/utils/constants/color_const.dart';
import 'package:book_store/presentation/utils/constants/poppins_font.dart';
import 'package:book_store/presentation/utils/my_icons.dart';
import 'package:book_store/presentation/widgets/book_info_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    return BlocBuilder<BookCubit, BookState>(
      builder: (BuildContext context, state) {
        if (state.status == Status.success) {
          return Scaffold(
            backgroundColor: ColorConst.white,
            body: SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: ColorConst.white,
                    leading: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: SvgPicture.asset(
                        MyIcons.arrowBackIcon,
                        color: ColorConst.black,
                        height: 15.h,
                      ),
                    ),
                    elevation: 0.0,
                    expandedHeight: 200.h,
                    title: Text(
                      widget.author.authorFullName,
                      style: PoppinsFont.w600,
                    ),
                    pinned: true,
                    centerTitle: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Padding(
                        padding: EdgeInsets.only(top: 50.h),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50.r),
                              child: CachedNetworkImage(
                                imageUrl: widget.author.authorImg,
                                height: 100.h,
                                placeholder: (context, url) {
                                  return const CircleShimmerItem();
                                },
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              "${state.authorBooks.length} books",
                              style: PoppinsFont.w400.copyWith(
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
                          BookModel bookItem = state.authorBooks[index];
                          return BookInfoItem(
                            bookItem: bookItem,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                RouteNames.bookDetail,
                                arguments: bookItem,
                              );
                            },
                          );
                        },
                        childCount: state.authorBooks.length,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 20.h,
                        crossAxisSpacing: 25.w,
                        childAspectRatio: 0.45.h,
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
