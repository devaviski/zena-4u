import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zena_foru/data/data.dart';
import 'package:zena_foru/providers/active_category_provider.dart';
import 'package:zena_foru/providers/active_country_provider.dart';
import 'package:zena_foru/providers/news_provider.dart';
import 'package:zena_foru/widgets/custom_fadein_image.dart';

class MainHeader extends ConsumerWidget {
  const MainHeader({
    super.key,
    required this.onRefreshPage,
  });
  final void Function(Future<void> initialState) onRefreshPage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allNews = ref.watch(newsProvider);
    final activeCategory = ref.watch(activeCategoryProvider);
    final activeCountry = ref.watch(activeCountryProvider);
    final headerNews = allNews['trending']![0];
    return Stack(
      children: [
        CustomFadeinImage(
          height: 180,
          image: headerNews.urlToImage != null
              ? NetworkImage(headerNews.urlToImage!)
              : null,
        ),
        Container(
          width: double.infinity,
          height: 180,
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
                  ref.read(activeCategoryProvider.notifier).setCategory(
                        categories[i],
                      );
                  onRefreshPage(
                    ref.read(newsProvider.notifier).loadNews(
                          query:
                              '"$activeCountry" ${categories[i].categoryName}',
                        ),
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
          right: 100,
          child: Text(
            headerNews.title!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  fontSize: 26,
                  color: Colors.white,
                ),
          ),
        ),
      ],
    );
  }
}
