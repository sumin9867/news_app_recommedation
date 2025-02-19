import 'package:flutter/material.dart';
import 'package:news/core/theme/app_color.dart';
import 'package:news/core/theme/responsive_size.dart';
import 'package:news/core/widget/news_app_bar.dart';
import 'package:news/features/hoempage/seacrh_widgets.dart';
import 'package:news/features/latest_news/presentation/latest_news_widget.dart';
<<<<<<< HEAD
import 'package:news/features/search/presentation/politics_news_list.dart';
=======
>>>>>>> 47f703e8b9d4b63d744e69fef8c73d0b80ff435d
import 'package:news/features/sports_news/presentation/sport_news_widgets.dart';

class NewsHomeScreen extends StatelessWidget {
  const NewsHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return Scaffold(
      backgroundColor: AppColor.attendanceContainer,
      appBar: const NewsAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
<<<<<<< HEAD
            GestureDetector(
              onTap: ()=>   // Navigate to the FilterScreen when the search bar is tapped
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FilterNewsScreen()),
        ),
              child: NewsSearchBar(
                // controller: searchController,
              ),
=======
            NewsSearchBar(
              controller: searchController,
>>>>>>> 47f703e8b9d4b63d744e69fef8c73d0b80ff435d
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: ScreenUtils.getWidth(context, .025),
                  bottom: ScreenUtils.getWidth(context, .02),
                  top: ScreenUtils.getHeight(context, .02)),
              child: Text(
                'Breaking News',
                style: TextStyle(
                  fontSize: ScreenUtils.getHeight(context, .025),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const LatestNewsWidget(),
            Padding(
              padding: EdgeInsets.only(
                  left: ScreenUtils.getWidth(context, .025),
                  top: ScreenUtils.getHeight(context, .023)),
              child: Text(
                'Reccommeded',
                style: TextStyle(
                  fontSize: ScreenUtils.getHeight(context, .025),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SportNews(),
          ],
        ),
      ),
    );
  }
}
