import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zena_foru/data/data.dart';
import 'package:zena_foru/model/category.dart';
import 'package:zena_foru/model/country.dart';
import 'package:zena_foru/model/news.dart';
import 'package:zena_foru/providers/active_category_provider.dart';
import 'package:zena_foru/providers/active_country_provider.dart';
import 'package:zena_foru/providers/http_fetch_provider.dart';
import 'package:zena_foru/providers/weather_provider.dart';
import 'package:zena_foru/screens/search_screen.dart';
import 'package:zena_foru/widgets/empty_list.dart';
import 'package:zena_foru/widgets/main_header.dart';
import 'package:zena_foru/widgets/main_drawer.dart';
import 'package:zena_foru/widgets/news_list.dart';
import 'package:zena_foru/widgets/slideshow_news.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  Future<void>? _initialState;
  List<News>? reservedNews;

  void _refreshPage({
    Country? country,
    Category? category,
  }) {
    reservedNews = null;
    final activeCountry = country ?? ref.watch(activeCountryProvider);
    final activeCategory = category ?? ref.watch(activeCategoryProvider);
    if (country != null) {
      ref.read(activeCountryProvider.notifier).setCountry(country);
    }
    if (category != null) {
      ref.read(activeCategoryProvider.notifier).setCategory(category);
    }
    setState(() {
      _initialState = ref.read(apisFetchProvider.notifier).fetchAPIsData(
            headlineParams: activeCategory != categories[0]
                ? {
                    'country': activeCountry!.shortName,
                    'category': activeCategory!.categoryName,
                  }
                : {
                    'country': activeCountry!.shortName,
                  },
            everythingsQuery: activeCategory != categories[0]
                ? '"${activeCountry.fullName}" AND (${activeCategory!.keyWords})'
                : '"${activeCountry.fullName}"',
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialState,
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          final topHeadlines = ref.watch(headlinesProvider);
          var allNews = ref.watch(allNewsProvider);
          if (reservedNews != null) {
            allNews = [...reservedNews!];
          }
          final cityData = ref.watch(nearTownProvider);
          final weatherData = ref.watch(weatherDataProvider);
          bool noTopHeadlines = topHeadlines == null || topHeadlines.isEmpty;
          bool noAllNews = allNews == null || allNews.isEmpty;
          return Scaffold(
            drawer: MainDrawer(
              onPageRefresh: _refreshPage,
              cityData: cityData,
              weatherData: weatherData,
            ),
            body: noAllNews && noTopHeadlines
                ? Center(
                    child: EmptyList(
                    onPageRefresh: _refreshPage,
                  ))
                : NestedScrollView(
                    headerSliverBuilder: (context, innerBoxIsScrolled) => [
                      SliverAppBar(
                        floating: true,
                        snap: true,
                        actions: [
                          IconButton(
                            onPressed: () {
                              reservedNews = [...allNews!];
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const SearchScreen(),
                                ),
                              );
                            },
                            icon: const Icon(Icons.search),
                          ),
                        ],
                        title: const Text('Top Headlines'),
                      )
                    ],
                    body: SizedBox(
                      height: double.infinity,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            MainHeader(
                              onRefreshPage: _refreshPage,
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            topHeadlines == null
                                ? const SizedBox()
                                : topHeadlines.isEmpty
                                    ? const SizedBox()
                                    : Column(
                                        children: [
                                          SlideshowNews(newNews: topHeadlines),
                                          const SizedBox(
                                            height: 24,
                                          ),
                                        ],
                                      ),
                            allNews == null
                                ? const SizedBox()
                                : allNews.isEmpty
                                    ? EmptyList(
                                        onPageRefresh: _refreshPage,
                                      ) //to be implemented
                                    : Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.only(
                                                left: 8, bottom: 4),
                                            width: double.infinity,
                                            child: Text(
                                              'All Stories...',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge,
                                            ),
                                          ),
                                          NewsList(
                                            allNews: allNews,
                                          ),
                                        ],
                                      ),
                          ],
                        ),
                      ),
                    ),
                  ),
          );
        }
      }),
    );
  }
}
