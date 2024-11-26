import 'package:news/features/sports_news/domain/sport_news_model.dart';

abstract class SportNewsState {}

class SportNewsInitial extends SportNewsState {}

class SportNewsLoaded extends SportNewsState {
  final SportNewsModel sportNewsModel;

  SportNewsLoaded({required this.sportNewsModel});
}

class SportNewsError extends SportNewsState {
  final String message;

  SportNewsError({required this.message});
}
