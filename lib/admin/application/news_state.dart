import 'package:news/admin/domain/admin_model.dart';

abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}
class NewsLoaded extends NewsState {
final List<NewsModel> news;

  NewsLoaded({required this.news});
}


class NewsAdded extends NewsState {}

class NewsError extends NewsState {
  final String message;
  NewsError(this.message);
}
