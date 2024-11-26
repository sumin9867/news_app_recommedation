import 'package:news/features/catagories_picker/domain/catogories_pciker_model.dart';

abstract class CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesSuccess extends CategoriesState {}

class CategoriesError extends CategoriesState {
  final String message;

  CategoriesError(this.message);
}

class CategoriesLoaded extends CategoriesState {
  final List<UserCategoriesModel> categories;

  CategoriesLoaded(this.categories);
}
