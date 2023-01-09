import 'package:book_store/cubits/book/book_cubit.dart';
import 'package:book_store/data/models/book/book_model.dart';
import 'package:book_store/data/models/category/category_model.dart';
import 'package:book_store/data/models/status.dart';
import 'package:book_store/presentation/widgets/simple_app_bar.dart';
import 'package:book_store/presentation/utils/constants/color_const.dart';
import 'package:book_store/presentation/views/category_book/view/widgets/category_book_img_item.dart';
import 'package:book_store/presentation/widgets/no_books_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/constants/route_names.dart';
import '../../../widgets/book_info_item.dart';

class CategoryBookScreen extends StatefulWidget {
  const CategoryBookScreen({
    super.key,
    required this.categoryModel,
  });

  @override
  State<CategoryBookScreen> createState() => _CategoryBookScreenState();

  final CategoryModel categoryModel;
}

class _CategoryBookScreenState extends State<CategoryBookScreen>
    with SingleTickerProviderStateMixin {
  bool animateOpacity = false;
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 700),
  )
    ..forward()
    ..addListener(() {
      if (_animationController.isCompleted) {
        setState(() {
          animateOpacity = true;
        });
      }
    });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookCubit, BookState>(
      builder: (context, state) {
        if (state.status == Status.success) {
          return Scaffold(
            backgroundColor: ColorConst.white,
            appBar: SimpleAppBar(
              title: widget.categoryModel.categoryName,
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(height: 15.h),
                  Center(
                    child: ScaleTransition(
                      scale: CurvedAnimation(
                        curve: Curves.linear,
                        parent: _animationController,
                      ),
                      child: CategoryBookImgItem(
                        imageUrl: widget.categoryModel.categoryImg,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: state.categoryBooks.isNotEmpty,
                    child: AnimatedOpacity(
                      opacity: animateOpacity ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 500),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: state.categoryBooks.length,
                        padding: EdgeInsets.all(25.sp),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 20.h,
                          crossAxisSpacing: 25.w,
                          childAspectRatio: MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height / 1),
                        ),
                        itemBuilder: (context, index) {
                          BookModel bookItem = state.categoryBooks[index];
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
                      ),
                    ),
                  ),
                  Visibility(
                    visible: state.categoryBooks.isEmpty,
                    child: AnimatedOpacity(
                      opacity: animateOpacity ? 1.0 : 0.0,
                      duration: const Duration(seconds: 2),
                      child: const NoBookItem(),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
