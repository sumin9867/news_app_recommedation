// import 'package:news/features/latest_news/application/latest_news_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/features/latest_news/application/latest_news_state.dart';
import 'package:news/features/latest_news/infrastructure/latest_news_repositary.dart';

class LatestNewsCubit extends Cubit<LatestNewsState> {
  final LatestNewsRepositary latestNewsRepositary;

  LatestNewsCubit(this.latestNewsRepositary) : super(LatestNewsInitial());
  Future<void> fetchLatestNews() async {
    try {
      emit(LatestNewsInitial());
      final latestNews = await latestNewsRepositary.fetchLatestNews();
      emit(LatestNewsLoaded(latestNews: latestNews));
    } catch (e) {
      emit(LatestNewsError(message: '$e'));
    }
  }
}
