import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location/location.dart';
import 'package:zena_foru/providers/http_fetch_provider.dart';
import 'package:zena_foru/providers/location.dart';
import 'package:zena_foru/screens/search_screen.dart';
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
  bool secondRound = false;
  List<Map<String, dynamic>>? cityData;

  @override
  void initState() {
    Future.delayed(
      const Duration(milliseconds: 1500),
      () {
        final LocationData? location = ref.watch(locationDataProvider);
        _initialState = ref.read(apisFetchProvider.notifier).fetchAPIsData(
            headlineParams: {'country': 'us'},
            everythingsQuery: '"USA"',
            locationData: location == null
                ? null
                : {'lat': location.latitude!, 'lon': location.longitude!});
        setState(() {
          secondRound = true;
        });
      },
    );
    super.initState();
  }

  void _refreshPage(Future<void> initialState) {
    setState(() {
      _initialState = initialState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialState,
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            !secondRound) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          final topHeadlines = ref.watch(headlinesProvider);
          final allNews = ref.watch(allNewsProvider);
          cityData = ref.watch(nearTownProvider);

          return Scaffold(
            drawer: MainDrawer(
              onPageRefresh: _refreshPage,
              cityData: cityData,
            ),
            body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  floating: true,
                  snap: true,
                  actions: [
                    IconButton(
                      onPressed: () {
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
                      Container(
                        padding: const EdgeInsets.only(left: 16, bottom: 2),
                        width: double.infinity,
                        child: Text(
                          'Trending...',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      topHeadlines.isEmpty
                          ? const SizedBox()
                          : SlideshowNews(newNews: topHeadlines.sublist(1)),
                      const SizedBox(
                        height: 24,
                      ),
                      NewsList(
                        allNews: allNews,
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
