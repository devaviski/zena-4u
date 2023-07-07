import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zena_foru/data/data.dart';
import 'package:zena_foru/model/category.dart';
import 'package:zena_foru/model/country.dart';
import 'package:zena_foru/providers/active_category_provider.dart';
import 'package:zena_foru/providers/http_fetch_provider.dart';
import 'package:zena_foru/screens/news_screen.dart';
import 'package:zena_foru/widgets/custom_fadein_image.dart';

class MainHeader extends ConsumerWidget {
  const MainHeader({
    super.key,
    required this.onRefreshPage,
  });
  final void Function({Country? country, Category? category}) onRefreshPage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeCategory = ref.watch(activeCategoryProvider);
    final headlineNews = ref.watch(headlinesProvider);
    final otherNews = ref.watch(allNewsProvider);
    final headerNews =
        headlineNews!.isNotEmpty ? headlineNews[0] : otherNews![0];

    if (headlineNews.isEmpty && otherNews!.isEmpty) {
      return const SizedBox();
    }
    return Stack(
      children: [
        CustomFadeinImage(
          height: 200,
          image: headerNews.urlToImage != null
              ? NetworkImage(headerNews.urlToImage!)
              : null,
        ),
        Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(0.5),
                Colors.black.withOpacity(0.8)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.fromLTRB(0, 16, 0, 4),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: categories.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  crossAxisSpacing: 2,
                  maxCrossAxisExtent: 100,
                  childAspectRatio: 3),
              itemBuilder: (context, i) => TextButton(
                style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: activeCategory == categories[i]
                        ? Colors.orange.withOpacity(0.75)
                        : Colors.transparent,
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 4)),
                onPressed: () {
                  onRefreshPage(
                    category: categories[i],
                  );
                },
                child: Text(
                  categories[i].categoryName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 16,
          left: 16,
          right: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                headerNews.title!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontSize: 24,
                      color: Colors.white,
                    ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => NewsScreen(url: headerNews.url!),
                    ),
                  );
                },
                child: const Text(
                  'Read more...',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                    height: 1.5,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
