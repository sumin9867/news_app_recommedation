import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/theme/app_color.dart';
import 'package:news/core/theme/responsive_size.dart';
import 'package:news/features/catagories_picker/application/catagories_picker_state.dart';
import 'package:news/features/catagories_picker/application/cubit/catagories_picker_cubit.dart';
import 'package:news/features/profile/application/cubit/profile_cubit_cubit.dart';
import 'package:news/features/profile/application/cubit/profile_cubit_state.dart';
import 'package:news/features/sports_news/application/sport_news_cubit.dart';
import 'package:news/features/sports_news/application/sport_news_state.dart';
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
    context.read<CategoriesCubit>().fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
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
      },
    );
  }
}
