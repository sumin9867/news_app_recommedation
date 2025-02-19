import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/admin/application/news_cubit.dart';
import 'package:news/admin/application/news_state.dart';
import 'package:news/core/theme/app_color.dart';
import 'package:news/core/theme/responsive_size.dart';
import 'package:news/features/profile/application/cubit/profile_cubit_cubit.dart';
import 'package:news/features/profile/application/cubit/profile_cubit_state.dart';
import 'package:news/features/sports_news/presentation/sport_news_list_view.dart';


class SportNews extends StatefulWidget {
  const SportNews({super.key});

  @override
  State<SportNews> createState() => _SportNewsState();
}

class _SportNewsState extends State<SportNews> {
  @override
  void initState() {
    super.initState();
    // Fetch the news and user details when the widget is initialized
    context.read<NewsCubit>().fetchNews();
    context.read<ProfileCubit>().fetchUserProfile(); // Assuming UserCubit manages user data
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, userState) {
        if (userState is ProfileLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (userState is ProfileLoaded) {
          final user = userState.userModel;

          return BlocBuilder<NewsCubit, NewsState>(
            builder: (context, newsState) {
              if (newsState is NewsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (newsState is NewsLoaded) {
                final news = newsState.news;

                if (news.isEmpty) {
                  return const Center(child: Text('No news available.'));
                }

                return Padding(
                  padding: EdgeInsets.only(top: ScreenUtils.getHeight(context, .02)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SportNewsListView(
                        sportNewsModel: news,
                        userLatitude: user.latitude??0, // Pass user latitude
                        userLongitude: user.longitude??0, // Pass user longitude
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                );
              } else if (newsState is NewsError) {
                return Center(child: Text(newsState.message));
              }

              return Container();
            },
          );
        } else if (userState is ProfileError) {
          return Center(child: Text(userState.message));
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
