import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/core/theme/app_color.dart';
import 'package:news/core/theme/responsive_size.dart';
import 'package:news/features/sports_news/domain/sport_news_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class SportNewsListView extends StatelessWidget {
  final SportNewsModel sportNewsModel;

  const SportNewsListView({super.key, required this.sportNewsModel});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: sportNewsModel.results?.length ?? 0,
      itemBuilder: (context, index) {
        final data = sportNewsModel.results?[index];
        final pubDate = data?.pubDate;
        final pubDateParsed = pubDate != null ? DateTime.parse(pubDate) : null;

        return Padding(
          padding: EdgeInsets.symmetric(
              vertical: 8.0, horizontal: ScreenUtils.getWidth(context, .02)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: data?.imageUrl == null
                    ? const SizedBox(
                        height: 100,
                        width: 100,
                        child: Center(child: Text('No Image')),
                      )
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
                            const Icon(Icons.error),
                      ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
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
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColor.primary,
                      ),
                      child: Text(
                        data!.keywords != null && data.keywords!.isNotEmpty
                            ? data.keywords!.join(', ')
                            : 'No keywords available',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColor.box,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
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
            ],
          ),
        );
      },
    );
  }
}
