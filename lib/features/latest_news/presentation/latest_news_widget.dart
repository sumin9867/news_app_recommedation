import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/theme/responsive_size.dart';
import 'package:news/features/latest_news/application/latest_news_cubit.dart';
import 'package:news/features/latest_news/application/latest_news_state.dart';
import 'package:news/features/latest_news/presentation/latest_news_list_view.dart';

class LatestNewsWidget extends StatelessWidget {
  const LatestNewsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenUtils.getHeight(context, .2),
      child: BlocBuilder<LatestNewsCubit, LatestNewsState>(
          builder: (context, state) {
        if (state is LatestNewsInitial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is LatestNewsLoaded) {
          return LatestNewsListView(
            latestNewsModel: state.latestNews,
          );
        } else if (state is LatestNewsError) {
          return Text(state.message);
        }
        return Container();
      }),
    );
  }
}
