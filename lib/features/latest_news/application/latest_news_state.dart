import 'package:news/features/latest_news/domain/latest_news_model.dart';

abstract class LatestNewsState {}

class LatestNewsInitial extends LatestNewsState {}

class LatestNewsLoaded extends LatestNewsState {
  final LatestNewsModel latestNews;

  LatestNewsLoaded({required this.latestNews});
}

class LatestNewsError extends LatestNewsState {
  final String message;

  LatestNewsError({required this.message});
}
