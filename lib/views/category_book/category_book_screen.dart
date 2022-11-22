import 'package:book_store/data/models/book/book_model.dart';
import 'package:book_store/data/models/category/category_model.dart';
import 'package:book_store/providers/book_provider.dart';
import 'package:book_store/utils/my_colors.dart';
import 'package:book_store/utils/my_fonts.dart';
import 'package:book_store/views/category_book/widgets/category_book_img_item.dart';
import 'package:book_store/views/category_book/widgets/no_books_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../constants/route_names.dart';
import '../../utils/my_icons.dart';
import '../author_book/widgets/book_info_item.dart';

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
    duration: const Duration(seconds: 1, milliseconds: 500),
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
    return StreamBuilder<List<BookModel>>(
      stream: context
          .read<BookProvider>()
          .getBooksByCategoryId(categoryId: widget.categoryModel.id),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            backgroundColor: MyColors.white,
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                widget.categoryModel.categoryName,
                style: MyFonts.w600,
              ),
              elevation: 0.0,
              backgroundColor: MyColors.white,
              leading: Center(
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: SvgPicture.asset(
                    MyIcons.arrowBackIcon,
                    color: MyColors.black,
                  ),
                ),
              ),
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
                    visible: snapshot.data!.isNotEmpty,
                    child: AnimatedOpacity(
                      opacity: animateOpacity ? 1.0 : 0.0,
                      duration: const Duration(seconds: 2),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 20.h),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 25,
                          childAspectRatio: 0.55,
                        ),
                        itemBuilder: (context, index) {
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
                      ),
                    ),
                  ),
                  Visibility(
                    visible: snapshot.data!.isEmpty,
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
