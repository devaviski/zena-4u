import 'dart:math';

import 'package:flutter/material.dart';
import 'package:zena_foru/model/news.dart';
import 'package:zena_foru/widgets/news_list_item.dart';

class NewsList extends StatelessWidget {
  const NewsList({super.key, required this.allNews});
  final List<News> allNews;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        if (width > 600) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 56, left: 4, right: 4),
            itemCount: min(allNews.length, 20),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 2,
              crossAxisCount: width > 1080 ? 3 : 2,
            ),
            itemBuilder: (context, i) => NewsListItem(
              news: allNews[i],
              isGrid: true,
            ),
          );
        }
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 56, left: 4, right: 4),
          itemCount: min(allNews.length, 20),
          itemBuilder: (ctx, i) {
            return NewsListItem(
              news: allNews[i],
              isGrid: false,
            );
          },
        );
      },
    );
  }
}
