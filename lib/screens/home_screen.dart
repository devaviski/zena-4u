import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zena_foru/providers/news_provider.dart';
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
  late Future<void> _initialState;
  @override
  void initState() {
    _initialState = ref.read(newsProvider.notifier).loadNews(
          query: '"USA"',
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
    final allNews = ref.watch(newsProvider);
    final topHeadlines = allNews['trending'];
    return Scaffold(
      drawer: MainDrawer(
        onPageRefresh: _refreshPage,
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
          child: FutureBuilder(
            future: _initialState,
            builder: ((context, snapshot) {
              return snapshot.connectionState == ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : SingleChildScrollView(
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
                          SlideshowNews(newNews: topHeadlines!),
                          const SizedBox(
                            height: 24,
                          ),
                          NewsList(
                            allNews: allNews['normal']!,
                          ),
                        ],
                      ),
                    );
            }),
          ),
        ),
      ),
    );
  }
}
