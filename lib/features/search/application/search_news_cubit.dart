import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news/features/search/application/search_news_state.dart';
import 'package:news/features/search/infrastructure/search_news_repositary.dart';

class SearchsNewsCubit extends Cubit<SearchNewsState> {
  final SearchNewsRepositary searchNewsRepositary;

  SearchsNewsCubit(this.searchNewsRepositary) : super(SearchNewsInitial());

  Future<void> fetchSearchNews(String? pagenumber) async {
    try {
      emit(SearchNewsInitial());
      final SearchNews =
          await searchNewsRepositary.fetchSearchNewsRepositaryNews(pagenumber);
      emit(SearchNewsLoaded(searchNewsModel: SearchNews));
    } catch (e) {
      emit(SearchNewsError(message: '$e'));
    }
  }

  void filterNewsByKeyword(String keyword) {
    print(state);
    print(keyword);
    if (state is SearchNewsLoaded) {
      final currentState = state as SearchNewsLoaded;
      final filteredResults =
          currentState.searchNewsModel.results?.where((result) {
        return result.keywords
                ?.any((k) => k.toLowerCase().contains(keyword.toLowerCase())) ??
            false;
      }).toList();

      emit(SearchNewsLoaded(
          searchNewsModel:
              currentState.searchNewsModel.copyWith(results: filteredResults)));
    }
  }
}
