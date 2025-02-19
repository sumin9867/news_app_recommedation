import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/admin/domain/admin_model.dart';
import 'package:news/core/theme/responsive_size.dart';
import 'package:news/features/sports_news/presentation/deatil_page.dart';
import 'package:news/features/sports_news/presentation/shortest_path_algortthm.dart';

class SportNewsListView extends StatelessWidget {
  final List<NewsModel> sportNewsModel;
  final double userLatitude;
  final double userLongitude;

  const SportNewsListView({
    super.key,
    required this.sportNewsModel,
    required this.userLatitude,
    required this.userLongitude,
  });

  @override
  Widget build(BuildContext context) {
    // Sort the news list by distance
    final sortedNewsModel = List<NewsModel>.from(sportNewsModel);
    sortedNewsModel.sort((a, b) {
      final distanceA = calculateDistance(
        userLatitude,
        userLongitude,
        a.latitude,
        a.longitude,
      );
      final distanceB = calculateDistance(
        userLatitude,
        userLongitude,
        b.latitude,
        b.longitude,
      );
      return distanceA.compareTo(distanceB); // Sort ascending (shortest distance first)
    });

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: sortedNewsModel.length,
      itemBuilder: (context, index) {
        final data = sortedNewsModel[index];

        // Calculate distance
        final distance = calculateDistance(
          userLatitude,
          userLongitude,
          data.latitude,
          data.longitude,
        );

        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SportNewsDetailPage(newsData: data),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: ScreenUtils.getWidth(context, .02),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: data.imageUrl == null
                      ? const SizedBox(
                          height: 100,
                          width: 100,
                          child: Center(child: Text('No Image')),
                        )
                      : CachedNetworkImage(
                          imageUrl: data.imageUrl ?? "",
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            height: 100,
                            width: 100,
                            color: Colors.grey[200],
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        data.shortDescription,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.location_on, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            '${distance.toStringAsFixed(1)} km away',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ],
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
