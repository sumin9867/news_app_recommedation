import 'package:flutter/material.dart';
import 'package:news/core/theme/app_color.dart';
import 'package:news/features/search/presentation/politics_news_list.dart';

class NewsSearchBar extends StatelessWidget {
  final Function()? onClear;

  const NewsSearchBar({
    super.key,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the FilterNewsScreen when the search bar is tapped
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FilterNewsScreen()), // Navigate to filter screen
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1, color: AppColor.grey),
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Row(
          children: [
            const Icon(Icons.search, color: Colors.grey, size: 30),
            Expanded(
              child: TextField(
                enabled: false, // Disable input in the text field
                decoration: const InputDecoration(
                  hintText: 'Find interesting News',
                  hintStyle: TextStyle(
                      fontSize: 14, color: Color.fromARGB(255, 193, 193, 193)),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColor.primary32, // Set the background color here
                borderRadius: BorderRadius.circular(20), // Rounded corners
              ),
              child: const Center(
                child: Text(
                  "Search",
                  style: TextStyle(
                    color: Colors.white, // Text color
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Assuming the FilterNewsScreen is implemented as below

