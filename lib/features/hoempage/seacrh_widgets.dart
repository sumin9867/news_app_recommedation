import 'package:flutter/material.dart';
import 'package:news/core/theme/app_color.dart';
<<<<<<< HEAD
import 'package:news/features/search/presentation/politics_news_list.dart';

class NewsSearchBar extends StatelessWidget {
=======

class NewsSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onSubmitted;
>>>>>>> 47f703e8b9d4b63d744e69fef8c73d0b80ff435d
  final Function()? onClear;

  const NewsSearchBar({
    super.key,
<<<<<<< HEAD
=======
    required this.controller,
    this.onSubmitted,
>>>>>>> 47f703e8b9d4b63d744e69fef8c73d0b80ff435d
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
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
=======
    return Container(
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
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Find intresting News',
                hintStyle: TextStyle(
                    fontSize: 14, color: Color.fromARGB(255, 193, 193, 193)),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
              ),
              onSubmitted: onSubmitted,
            ),
          ),
          InkWell(
            onTap: () {
              print(controller.text);
            },
            child: Container(
>>>>>>> 47f703e8b9d4b63d744e69fef8c73d0b80ff435d
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
<<<<<<< HEAD
          ],
        ),
=======
          ),
          if (controller.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear, color: Colors.grey),
              onPressed: onClear,
            ),
        ],
>>>>>>> 47f703e8b9d4b63d744e69fef8c73d0b80ff435d
      ),
    );
  }
}
<<<<<<< HEAD

// Assuming the FilterNewsScreen is implemented as below

=======
>>>>>>> 47f703e8b9d4b63d744e69fef8c73d0b80ff435d
