import 'package:book_store/cubits/author/author_cubit.dart';
import 'package:book_store/cubits/category/category_cubit.dart';
import 'package:book_store/data/models/status.dart';
import 'package:book_store/data/repositories/author_repository.dart';
import 'package:book_store/data/repositories/category_repository.dart';
import 'package:book_store/presentation/utils/constants/route_names.dart';
import 'package:book_store/presentation/utils/my_colors.dart';
import 'package:book_store/presentation/views/tab_box/tabs/home/search_delegate/search_delegate_screen.dart';
import 'package:book_store/presentation/views/tab_box/tabs/home/widgets/author_name_item.dart';
import 'package:book_store/presentation/views/tab_box/tabs/home/widgets/carousel_item.dart';
import 'package:book_store/presentation/views/tab_box/tabs/home/widgets/category_item.dart';
import 'package:book_store/presentation/views/tab_box/tabs/home/widgets/search_button.dart';
import 'package:book_store/presentation/views/tab_box/tabs/home/widgets/see_all_item.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../data/models/book/book_model.dart';
import '../../../../../providers/book_provider.dart';

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
                          Navigator.pushNamed(context, RouteNames.bookDetail,
                              arguments: books[index]);
                        },
                        bookItem: books[index],
                        visible: selectedIndexItemOnCarousel == index,
                      );
                    },
                    options: CarouselOptions(
                      height: 320.h,
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
                    title: "Genres",
                    seeAllOnPressed: () {},
                  ),
                  BlocProvider(
                    create: (context) => CategoryCubit(
                      categoryRepository: CategoryRepository(
                        firestore: FirebaseFirestore.instance,
                      ),
                    )..getCategories(),
                    child: BlocBuilder<CategoryCubit, CategoryState>(
                      builder: (context, state) {
                        if (state.status == Status.success) {
                          return SizedBox(
                            height: 120.h,
                            child: ListView(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              children: List.generate(
                                state.categories.length,
                                (index) => CategoryItem(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      RouteNames.categoryBook,
                                      arguments: state.categories[index],
                                    );
                                  },
                                  categoryItem: state.categories[index],
                                ),
                              ),
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                  SizedBox(height: 20.h),
                  SeeAllItem(
                    title: "Authors",
                    seeAllOnPressed: () {},
                  ),
                  BlocProvider(
                    create: (context) => AuthorCubit(
                      authorRepository: AuthorRepository(
                        firebaseFirestore: FirebaseFirestore.instance,
                      ),
                    )..getAuthors(),
                    child: BlocBuilder<AuthorCubit, AuthorState>(
                      builder: (context, state) {
                        if (state.status == Status.success) {
                          return SizedBox(
                            height: 30.h,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              children: List.generate(
                                state.authors.length,
                                (index) => AuthorNameItem(
                                  authorName:
                                      state.authors[index].authorFullName,
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      RouteNames.authorBook,
                                      arguments: state.authors[index],
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
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
