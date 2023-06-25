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
        if (constraints.maxWidth > 600) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 56, left: 4, right: 4),
            itemCount: allNews.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 2,
              crossAxisCount: 2,
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
          itemCount: allNews.length,
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
