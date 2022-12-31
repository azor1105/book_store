import 'package:book_store/app/app_cubit/app_cubit.dart';
import 'package:book_store/data/service/hive/hive_service.dart';
import 'package:book_store/presentation/utils/constants/route_names.dart';
import 'package:book_store/data/models/book/book_model.dart';
import 'package:book_store/presentation/utils/constants/color_const.dart';
import 'package:book_store/presentation/utils/constants/poppins_font.dart';
import 'package:book_store/presentation/views/book_detail/widgets/book_detail_info_item.dart';
import 'package:book_store/presentation/views/book_detail/widgets/book_detail_item.dart';
import 'package:book_store/presentation/views/book_detail/widgets/download_button.dart';
import 'package:book_store/presentation/views/book_detail/widgets/save_button.dart';
import 'package:book_store/presentation/widgets/buttons/custom_rectangle_text_button.dart';
import 'package:book_store/presentation/widgets/buttons/simple_text_button.dart';
import 'package:book_store/presentation/widgets/simple_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      appBar: SimpleAppBar(
        title: '',
        actions: [
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: SaveBookButton(
                bookModel: widget.bookModel,
                userId: context.read<AppCubit>().state.user!.uid,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: ColorConst.white,
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
                        style: PoppinsFont.w300.copyWith(
                          fontSize: 18.sp,
                          color: ColorConst.blackWithOpacity087,
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
                    Row(
                      children: [
                        Expanded(
                          child: CustomRectangleTextButton(
                            height: 50.h,
                            radius: 12.r,
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                RouteNames.pdfView,
                                arguments: [
                                  widget.bookModel,
                                  HiveService.getBookPath(
                                    bookId: widget.bookModel.id,
                                  ),
                                ],
                              );
                            },
                            title: 'Read book',
                          ),
                        ),
                        SizedBox(width: 20.w),
                        DownloadButton(bookModel: widget.bookModel),
                      ],
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
