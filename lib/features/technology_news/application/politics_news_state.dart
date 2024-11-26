import 'package:news/features/technology_news/domain/politics_news_model.dart';

abstract class PoliticsNewsState {}

class PoliticsNewsInitial extends PoliticsNewsState {}

class PoliticsNewsLoaded extends PoliticsNewsState {
  final PoliticsNewsModel politicsNewsModel;

  PoliticsNewsLoaded({required this.politicsNewsModel});
}

class PoliticsNewsError extends PoliticsNewsState {
  final String message;

  PoliticsNewsError({required this.message});
}
