import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:book_store/data/models/category/category_model.dart';
import 'package:book_store/data/models/status.dart';
import 'package:book_store/data/repositories/category_repository.dart';
import 'package:equatable/equatable.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit({required CategoryRepository categoryRepository})
      : _categoryRepository = categoryRepository,
        super(const CategoryState(categories: []));

  final CategoryRepository _categoryRepository;
  late StreamSubscription<List<CategoryModel>> _streamSubscription;

  void getCategories() {
    emit(state.copyWith(status: Status.loading));
    _streamSubscription = _categoryRepository.getAllCategories().listen(
      (categories) {
        emit(
          state.copyWith(
            categories: categories,
            status: Status.success,
          ),
        );
      },
      onError: (error) {
        emit(
          state.copyWith(
            status: Status.error,
            errorText: error.toString(),
          ),
        );
      },
    );
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
