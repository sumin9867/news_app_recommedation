import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/features/technology_news/application/politics_news_state.dart';
import 'package:news/features/technology_news/infrastructure/politics_news_repositary.dart';

class PoliticsNewsCubit extends Cubit<PoliticsNewsState> {
  final PoliticsNewsRepositary politicsNewsRepositary;

  PoliticsNewsCubit(
    this.politicsNewsRepositary,
  ) : super(PoliticsNewsInitial());

  Future<void> fetchPoliticsNews(String catagories) async {
    try {
      emit(PoliticsNewsInitial());
      final politicsNews = await politicsNewsRepositary.fetchPoliticsNews(
          categories: catagories);
      emit(PoliticsNewsLoaded(politicsNewsModel: politicsNews));
    } catch (e) {
      emit(PoliticsNewsError(message: '$e'));
    }
  }
}
