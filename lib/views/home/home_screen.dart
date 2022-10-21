import 'package:book_store/constants/route_names.dart';
import 'package:book_store/data/models/author/author_model.dart';
import 'package:book_store/data/models/category/category_model.dart';
import 'package:book_store/providers/author_provider.dart';
import 'package:book_store/providers/category_provider.dart';
import 'package:book_store/utils/my_colors.dart';
import 'package:book_store/views/home/search_delegate/search_delegate_screen.dart';
import 'package:book_store/views/home/widgets/author_name_item.dart';
import 'package:book_store/views/home/widgets/carousel_item.dart';
import 'package:book_store/views/home/widgets/category_item.dart';
import 'package:book_store/views/home/widgets/search_button.dart';
import 'package:book_store/views/home/widgets/see_all_item.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../data/models/book/book_model.dart';
import '../../providers/book_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  int selectedIndexItemOnCarousel = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      body: StreamBuilder<List<BookModel>>(
        stream: context.read<BookProvider>().getAllBooks(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            final books = snapshot.data!;
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: SearchButton(
                      searchOnPressed: () {
                        showSearch(
                          context: context,
                          delegate: SearchDelegateScreen(),
                        );
                      },
                    ),
                  ),
                  CarouselSlider.builder(
                    itemCount: books.length,
                    itemBuilder: (context, index, realIndex) {
                      return CarouselItem(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            RouteNames.bookDetail,
                            arguments: books[index].id,
                          );
                        },
                        bookItem: books[index],
                        visible: selectedIndexItemOnCarousel == index,
                      );
                    },
                    options: CarouselOptions(
                      height: 320,
                      viewportFraction: 0.55,
                      aspectRatio: 8,
                      enlargeCenterPage: true,
                      onPageChanged: (index, covariant) {
                        setState(() {
                          selectedIndexItemOnCarousel = index;
                        });
                      },
                    ),
                  ),
                  SeeAllItem(
                    title: "Categories",
                    seeAllOnPressed: () {},
                  ),
                  StreamBuilder<List<CategoryModel>>(
                    stream: context.read<CategoryProvider>().getAllCategories(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final categories = snapshot.data!;
                        return SizedBox(
                          height: 120,
                          child: ListView(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            children: List.generate(
                              categories.length,
                              (index) => CategoryItem(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    RouteNames.categoryBook,
                                    arguments: categories[index],
                                  );
                                },
                                categoryItem: categories[index],
                              ),
                            ),
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                  SizedBox(height: 20.h),
                  SeeAllItem(
                    title: "Authors",
                    seeAllOnPressed: () {},
                  ),
                  StreamBuilder<List<AuthorModel>>(
                    stream: context.read<AuthorProvider>().getAllAuthors(),
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.hasData) {
                        final authors = snapshot.data!;
                        return SizedBox(
                          height: 30.h,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            children: List.generate(
                              authors.length,
                              (index) => AuthorNameItem(
                                authorName: authors[index].authorFullName,
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    RouteNames.authorBook,
                                    arguments: authors[index],
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
