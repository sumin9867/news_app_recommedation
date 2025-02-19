import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/admin/application/news_state.dart';
import 'package:news/admin/domain/admin_model.dart';
import 'package:news/admin/infeasturutucre/admin_add_news_repo.dart';


class NewsCubit extends Cubit<NewsState> {
  final NewsRepository newsRepository;

  NewsCubit(this.newsRepository) : super(NewsInitial());

  // Add news to Firestore
  Future<void> addNews(NewsModel news) async {
    emit(NewsLoading());
    try {
      await newsRepository.addNews(news);
      emit(NewsAdded());
    } catch (e) {
      emit(NewsError('Failed to add news: $e'));
    }
  }
   Future<void> fetchNews() async {
    try {
      emit(NewsLoading());
      List<NewsModel> newsList = await newsRepository.fetchNews();
      emit(NewsLoaded(news: newsList));
    } catch (e) {
      emit(NewsError('Failed to load news: $e'));
    }
  }
}
