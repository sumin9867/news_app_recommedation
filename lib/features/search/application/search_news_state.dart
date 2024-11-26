import 'package:news/features/search/domain/search_news_model.dart';

abstract class SearchNewsState {}

class SearchNewsInitial extends SearchNewsState {}

class SearchNewsLoaded extends SearchNewsState {
  final SearchNewsModel searchNewsModel;

  SearchNewsLoaded({required this.searchNewsModel});
}

class SearchNewsError extends SearchNewsState {
  final String message;

  SearchNewsError({required this.message});
}
