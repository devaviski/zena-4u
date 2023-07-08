import 'package:flutter/material.dart';
import 'package:zena_foru/model/news.dart';
import 'package:zena_foru/screens/news_screen.dart';
import 'package:zena_foru/widgets/custom_fadein_image.dart';

class NewsListItem extends StatelessWidget {
  const NewsListItem({
    super.key,
    required this.news,
    required this.isGrid,
  });
  final News news;
  final bool isGrid;

  @override
  Widget build(BuildContext context) {
    String newsDate = 'Yesterday';
    final dateDiff = DateTime.now().day - DateTime.parse(news.publishAt!).day;
    if (dateDiff == 0) {
      newsDate = 'Today';
    } else if (dateDiff < 2) {
      newsDate = 'Yesterday';
    } else {
      newsDate = '$dateDiff days';
    }
    late ImageProvider? targetImage;
    try {
      targetImage = NetworkImage(news.urlToImage!);
    } catch (e) {
      targetImage = null;
    }
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => NewsScreen(
                url: news.url!,
              ),
            ),
          );
        },
        child: Stack(
          children: [
            CustomFadeinImage(
              height: isGrid ? null : 250,
              imageUrl: news.urlToImage,
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(16),
                      bottomRight: Radius.circular(16)),
                  gradient: LinearGradient(
                    colors: [
                      Colors.orange.withOpacity(0.8),
                      Colors.orange.withOpacity(0.4),
                    ],
                  ),
                ),
                child: Text(
                  news.source!['name'],
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color:
                    Theme.of(context).colorScheme.background.withOpacity(0.9),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      news.title!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      news.description ?? news.publishAt!,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      newsDate,
                      textAlign: TextAlign.end,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .color!
                              .withOpacity(0.8)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
