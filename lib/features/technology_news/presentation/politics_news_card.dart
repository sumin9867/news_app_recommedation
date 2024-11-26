import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/core/theme/responsive_size.dart';
import 'package:news/features/technology_news/domain/politics_news_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class PoliticsNewsCard extends StatelessWidget {
  final PoliticsNewsModel politicsNewsModel;

  const PoliticsNewsCard({super.key, required this.politicsNewsModel});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(
          politicsNewsModel.results?.length ?? 0,
          (index) {
            final data = politicsNewsModel.results?[index];
            final pubDate = data?.pubDate;
            final pubDateParsed =
                pubDate != null ? DateTime.parse(pubDate) : null;

            return Padding(
              padding: EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: ScreenUtils.getWidth(context, .02),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: data?.imageUrl == null
                        ? const SizedBox()
                        : CachedNetworkImage(
                            imageUrl: data?.imageUrl ?? "",
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
                                const Icon(Icons.error)),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtils.getWidth(context, .02),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data?.title ?? "",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Icon(
                                Icons.timeline_rounded,
                                size: 20,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                pubDateParsed != null
                                    ? timeago.format(pubDateParsed,
                                        locale: 'en_short')
                                    : 'Unknown',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
