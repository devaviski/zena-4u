import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:zena_foru/model/news.dart';
import 'package:zena_foru/screens/top_headlines.dart';
import 'package:zena_foru/widgets/custom_fadein_image.dart';

class SlideshowNews extends StatelessWidget {
  const SlideshowNews({
    super.key,
    required this.newNews,
  });

  final List<News> newNews;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: newNews
          .sublist(0, min(newNews.length, 10))
          .map(
            (e) => Card(
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => TopHeadlines(
                        headlineNews: newNews,
                        currentNews: e,
                      ),
                    ),
                  );
                },
                child: Stack(
                  children: [
                    CustomFadeinImage(
                      height: 150,
                      image: e.urlToImage != null && e.urlToImage!.length > 3
                          ? NetworkImage(e.urlToImage!)
                          : null,
                    ),
                    Container(
                      height: 150,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context)
                                .colorScheme
                                .background
                                .withOpacity(0.95),
                            Theme.of(context)
                                .colorScheme
                                .background
                                .withOpacity(0),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Text(
                        e.title!,
                        style: Theme.of(context).textTheme.titleMedium,
                        maxLines: 2,
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
          .toList(),
      options: CarouselOptions(
        height: 150,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 10),
      ),
    );
  }
}
