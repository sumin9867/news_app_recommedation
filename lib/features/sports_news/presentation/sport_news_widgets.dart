import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
<<<<<<< HEAD
import 'package:news/admin/application/news_cubit.dart';
import 'package:news/admin/application/news_state.dart';
import 'package:news/core/theme/app_color.dart';
import 'package:news/core/theme/responsive_size.dart';
import 'package:news/features/profile/application/cubit/profile_cubit_cubit.dart';
import 'package:news/features/profile/application/cubit/profile_cubit_state.dart';
import 'package:news/features/sports_news/presentation/sport_news_list_view.dart';


=======
import 'package:news/core/theme/app_color.dart';
import 'package:news/core/theme/responsive_size.dart';
import 'package:news/features/catagories_picker/application/catagories_picker_state.dart';
import 'package:news/features/catagories_picker/application/cubit/catagories_picker_cubit.dart';
import 'package:news/features/profile/application/cubit/profile_cubit_cubit.dart';
import 'package:news/features/profile/application/cubit/profile_cubit_state.dart';
import 'package:news/features/sports_news/application/sport_news_cubit.dart';
import 'package:news/features/sports_news/application/sport_news_state.dart';
import 'package:news/features/sports_news/presentation/sport_news_list_view.dart';

>>>>>>> 47f703e8b9d4b63d744e69fef8c73d0b80ff435d
class SportNews extends StatefulWidget {
  const SportNews({super.key});

  @override
  State<SportNews> createState() => _SportNewsState();
}

class _SportNewsState extends State<SportNews> {
  @override
  void initState() {
    super.initState();
<<<<<<< HEAD
    // Fetch the news and user details when the widget is initialized
    context.read<NewsCubit>().fetchNews();
    context.read<ProfileCubit>().fetchUserProfile(); // Assuming UserCubit manages user data
=======
    context.read<CategoriesCubit>().fetchCategories();
>>>>>>> 47f703e8b9d4b63d744e69fef8c73d0b80ff435d
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
<<<<<<< HEAD
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
=======
      builder: (context, profileState) {
        if (profileState is ProfileLoaded) {
          final userId = profileState.userModel.id;

          return BlocBuilder<CategoriesCubit, CategoriesState>(
            builder: (context, categoriesState) {
              if (categoriesState is CategoriesLoaded) {
                final userCategories = categoriesState.categories
                    .where((category) => category.userId == userId)
                    .map((category) => category.categories)
                    .expand((categories) => categories)
                    .toSet();

                return BlocBuilder<SportsNewsCubit, SportNewsState>(
                  builder: (context, sportsNewsState) {
                    if (sportsNewsState is SportNewsInitial) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (sportsNewsState is SportNewsLoaded) {
                      final filteredArticles = sportsNewsState
                              .sportNewsModel.results
                              ?.where((article) {
                            return article.keywords
                                    ?.any(userCategories.contains) ??
                                false;
                          }).toList() ??
                          [];

                      return Padding(
                        padding: EdgeInsets.only(
                            top: ScreenUtils.getHeight(context, .02)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SportNewsListView(
                                sportNewsModel: sportsNewsState.sportNewsModel
                                    .copyWith(results: filteredArticles)),
                            SizedBox(
                                height: ScreenUtils.getHeight(context, .02)),
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  context
                                      .read<SportsNewsCubit>()
                                      .fetchSportNews(sportsNewsState
                                          .sportNewsModel.nextPage);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.primary,
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          ScreenUtils.getWidth(context, .02),
                                      vertical: 4),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: const Text(
                                  "Load More",
                                  style: TextStyle(
                                      color: AppColor.box,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      );
                    } else if (sportsNewsState is SportNewsError) {
                      return Center(child: Text(sportsNewsState.message));
                    }
                    return Container();
                  },
                );
              }
              return Container();
            },
          );
        }
        return Container();
>>>>>>> 47f703e8b9d4b63d744e69fef8c73d0b80ff435d
      },
    );
  }
}
