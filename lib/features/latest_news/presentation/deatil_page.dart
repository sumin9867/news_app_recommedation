import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:news/features/latest_news/domain/latest_news_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:timeago/timeago.dart' as timeago;

class LatestNewsDetailPage extends StatelessWidget {
  final Results newsData;

  const LatestNewsDetailPage({super.key, required this.newsData});

  @override
  Widget build(BuildContext context) {
    final pubDate = newsData.pubDate;
    final pubDateParsed = pubDate != null ? DateTime.parse(pubDate) : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('News Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Image
            CachedNetworkImage(
              imageUrl: newsData.imageUrl ?? "",
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey[300],
                child: const Icon(
                  Icons.image_not_supported,
                  color: Colors.white,
                  size: 80,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    newsData.title ?? "No Title",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  // Publication Date
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        size: 20,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        pubDateParsed != null
                            ? timeago.format(pubDateParsed)
                            : 'Unknown Date',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),

                   Text(
                    newsData.description ?? "",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Keywords (if available)
                  if (newsData.keywords != null && newsData.keywords!.isNotEmpty)
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: newsData.keywords!
                          .map((keyword) => Chip(
                                label: Text(
                                  keyword,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                backgroundColor: Colors.blueAccent,
                              ))
                          .toList(),
                    ),
                  const SizedBox(height: 20),
                  // Button to Open Original Link
                  if (newsData.link != null && newsData.link!.isNotEmpty)
                    Center(
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.link),
                        label: const Text('Read Full Article'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                        ),
                        onPressed: () async {
                          final Uri url = Uri.parse(newsData.link!);
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Could not open the link'),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
