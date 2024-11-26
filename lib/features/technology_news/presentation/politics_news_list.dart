import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/theme/app_color.dart';
import 'package:news/core/widget/news_app_bar.dart';
import 'package:news/features/technology_news/application/politics_news_cubit.dart';
import 'package:news/features/technology_news/application/politics_news_state.dart';
import 'package:news/features/technology_news/presentation/politics_news_card.dart';

class NewsCategories extends StatefulWidget {
  const NewsCategories({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NewsCategoriesState createState() => _NewsCategoriesState();
}

class _NewsCategoriesState extends State<NewsCategories> {
  String _selectedCategory = 'sports';

  @override
  void initState() {
    super.initState();
    context.read<PoliticsNewsCubit>().fetchPoliticsNews("sports");
  }

  @override
  Widget build(BuildContext context) {
    final categories = [
      'sports',
      'business',
      'entertainment',
      'science',
      'health',
      'world',
      'environment',
      'food',
    ];

    return Scaffold(
      backgroundColor: AppColor.attendanceContainer,
      appBar: const NewsAppBar(),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = _selectedCategory == category;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCategory = category;
                    });
                    context
                        .read<PoliticsNewsCubit>()
                        .fetchPoliticsNews(_selectedCategory);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.black
                          : const Color.fromARGB(255, 217, 216, 216),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        category.toUpperCase(),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<PoliticsNewsCubit, PoliticsNewsState>(
              builder: (context, state) {
                if (state is PoliticsNewsInitial) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is PoliticsNewsLoaded) {
                  return PoliticsNewsCard(
                      politicsNewsModel: state.politicsNewsModel);
                } else if (state is PoliticsNewsError) {
                  return Center(child: Text('Error: ${state.message}'));
                } else {
                  return const Center(
                    child: Text('Select a category to see news'),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
