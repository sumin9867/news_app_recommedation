import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart'; // Import CachedNetworkImage
import 'package:news/core/theme/responsive_size.dart';
import 'package:news/features/latest_news/domain/latest_news_model.dart';
import 'package:news/features/latest_news/presentation/deatil_page.dart';
import 'package:timeago/timeago.dart' as timeago;

class LatestNewsListView extends StatelessWidget {
  final LatestNewsModel latestNewsModel;
  const LatestNewsListView({super.key, required this.latestNewsModel});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: latestNewsModel.results?.length ?? 0,
      itemBuilder: (context, index) {
        final data = latestNewsModel.results?[index];
        final pubDate = data?.pubDate;
        final pubDateParsed = pubDate != null ? DateTime.parse(pubDate) : null;

        return Padding(
          padding: EdgeInsets.only(left: ScreenUtils.getWidth(context, .02)),
          child: GestureDetector(

            onTap: ()=> Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => LatestNewsDetailPage(newsData: latestNewsModel.results![index]),
  ),
)
,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    imageUrl: data?.imageUrl ?? "",
                    width: ScreenUtils.getWidth(context, .4),
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey[300], // Set background color for fallback
                      child: const Icon(
                        Icons.image_not_supported,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.7),
                          Colors.black.withOpacity(0)
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.center,
                      ),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data?.title ?? "",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(
                              Icons.published_with_changes_rounded,
                              size: 20,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              pubDateParsed != null
                                  ? timeago.format(pubDateParsed,
                                      locale: 'en_short')
                                  : 'Unknown',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
