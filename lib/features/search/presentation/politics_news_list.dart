import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/theme/app_color.dart';
import 'package:news/core/widget/news_app_bar.dart';
import 'package:news/features/search/application/search_news_cubit.dart';
import 'package:news/features/search/application/search_news_state.dart';
import 'package:news/features/search/presentation/politics_news_card.dart';

class FilterNewsScreen extends StatefulWidget {
  const FilterNewsScreen({super.key});

  @override
  _FilterNewsScreenState createState() => _FilterNewsScreenState();
}

class _FilterNewsScreenState extends State<FilterNewsScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Initial fetch with empty keyword
    context.read<SearchsNewsCubit>().fetchSearchNews("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.attendanceContainer,
      appBar: const NewsAppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search by Keyword',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                // Trigger search whenever the input changes
                context.read<SearchsNewsCubit>().filterNewsByKeyword(value);
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<SearchsNewsCubit, SearchNewsState>(
              builder: (context, state) {
                if (state is SearchNewsInitial) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is SearchNewsLoaded) {
                  final results = state.searchNewsModel.results;
                  if (results == null || results.isEmpty) {
                    return const Center(child: Text('No results found.'));
                  }
                  return ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      final newsItem = results[index];
                      return SearchNewsCard(
                        newsItem: newsItem,
                      );
                    },
                  );
                } else if (state is SearchNewsError) {
                  return Center(child: Text('Error: ${state.message}'));
                } else {
                  return const Center(
                    child: Text('Start searching by entering a keyword'),
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
