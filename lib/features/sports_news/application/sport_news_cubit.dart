import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news/features/sports_news/application/sport_news_state.dart';
import 'package:news/features/sports_news/infrastructure/sport_news_repositary.dart';

class SportsNewsCubit extends Cubit<SportNewsState> {
  final SportNewsRepositary sportNewsRepositary;

  SportsNewsCubit(
    this.sportNewsRepositary,
  ) : super(SportNewsInitial());
  Future<void> fetchSportNews(String? pagenumber) async {
    try {
      emit(SportNewsInitial());
      final sportNews =
          await sportNewsRepositary.fetchSportNews(pagenumber ?? "");
      emit(SportNewsLoaded(sportNewsModel: sportNews));
    } catch (e) {
      emit(SportNewsError(message: '$e'));
    }
  }
}
