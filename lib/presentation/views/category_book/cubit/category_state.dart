part of 'category_cubit.dart';

class CategoryState extends Equatable {
  const CategoryState({
    required this.categories,
    this.errorText = '',
    this.status = Status.pure,
  });
  final Status status;
  final String errorText;
  final List<CategoryModel> categories;

  CategoryState copyWith({
    Status? status,
    String? errorText,
    List<CategoryModel>? categories,
  }) =>
      CategoryState(
        categories: categories ?? this.categories,
        errorText: errorText ?? this.errorText,
        status: status ?? this.status,
      );

  @override
  List<Object> get props => [categories, status, errorText];
}
