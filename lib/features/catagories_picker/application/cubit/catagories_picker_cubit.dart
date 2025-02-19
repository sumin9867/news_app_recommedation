import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/features/catagories_picker/application/catagories_picker_state.dart';
import 'package:news/features/catagories_picker/domain/catogories_pciker_model.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesLoading());

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveCategories(
      {required UserCategoriesModel userCategories}) async {
    emit(CategoriesLoading());

    try {
      await _firestore.collection('categories').add(userCategories.toJson());
      emit(CategoriesSuccess());
    } catch (e) {
      emit(CategoriesError("Error saving categories: ${e.toString()}"));
    }
  }

  Future<void> fetchCategories() async {
    emit(CategoriesLoading());

    try {
      final querySnapshot = await _firestore.collection('categories').get();
      final categories = querySnapshot.docs.map((doc) {
        return UserCategoriesModel.fromJson(doc.data());
      }).toList();

      emit(CategoriesLoaded(categories));
    } catch (e) {
      emit(CategoriesError("Error fetching categories: ${e.toString()}"));
    }
  }
}
