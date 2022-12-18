import 'package:book_store/presentation/utils/constants/route_names.dart';
import 'package:book_store/data/models/book/book_model.dart';
import 'package:book_store/presentation/utils/my_colors.dart';
import 'package:book_store/presentation/utils/my_fonts.dart';
import 'package:book_store/presentation/views/book_detail/widgets/book_detail_info_item.dart';
import 'package:book_store/presentation/views/book_detail/widgets/book_detail_item.dart';
import 'package:book_store/presentation/views/book_detail/widgets/save_button.dart';
import 'package:book_store/presentation/widgets/buttons/simple_text_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../utils/my_icons.dart';

class BookDetailScreen extends StatefulWidget {
  const BookDetailScreen({
    super.key,
    required this.bookModel,
  });

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();

  final BookModel bookModel;
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  bool readMore = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: MyColors.white,
        actions: [
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: SaveBookButton(
                bookItem: widget.bookModel,
                userId: context.read<User?>()!.uid,
              ),
            ),
          ),
        ],
        leading: Center(
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: SvgPicture.asset(
              MyIcons.arrowBackIcon,
              color: MyColors.black,
              height: 15.h,
            ),
          ),
        ),
      ),
      backgroundColor: MyColors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: BookDetailItem(
                  bookItem: widget.bookModel,
                ),
              ),
              SizedBox(height: 18.h),
              Padding(
                padding: EdgeInsets.only(left: 17.w, right: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: readMore ? 60.h : null,
                      child: Text(
                        widget.bookModel.description,
                        style: MyFonts.w300.copyWith(
                          fontSize: 18.sp,
                          color: MyColors.blackWithOpacity087,
                          overflow: readMore ? TextOverflow.ellipsis : null,
                        ),
                        maxLines: readMore ? 2 : null,
                      ),
                    ),
                    Center(
                      child: SimpleTextButton(
                        title: readMore ? "Read more" : "Close",
                        onPressed: () {
                          setState(() {
                            readMore = !readMore;
                          });
                        },
                      ),
                    ),
                    BookDetailInfoItem(bookItem: widget.bookModel),
                    SizedBox(height: 20.h),
                    SizedBox(
                      height: 70.h,
                      width: double.infinity,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.r),
                          ),
                          backgroundColor: MyColors.c8687E7,
                        ),
                        onPressed: () async {
                          // MyUtils.showLoader(context);
                          // final pdf = await ApiServices.loadFirebase(
                          //     widget.bookModel.bookPdfPath);
                          // Navigator.of(context).pop();
                          Navigator.pushNamed(
                            context,
                            RouteNames.pdfView,
                            arguments: widget.bookModel,
                          );
                        },
                        child: Center(
                          child: Text(
                            "Read book",
                            style: MyFonts.w600.copyWith(
                              color: MyColors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
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
