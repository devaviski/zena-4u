import 'package:flutter/material.dart';
import 'package:zena_foru/model/news.dart';
import 'package:zena_foru/screens/news_screen.dart';
import 'package:zena_foru/widgets/custom_fadein_image.dart';
import 'package:zena_foru/widgets/news_list.dart';
import 'package:palette_generator/palette_generator.dart';

class TopHeadlines extends StatefulWidget {
  const TopHeadlines({
    super.key,
    required this.headlineNews,
    required this.currentNews,
  });
  final List<News> headlineNews;
  final News currentNews;

  @override
  State<TopHeadlines> createState() => _TopHeadlinesState();
}

class _TopHeadlinesState extends State<TopHeadlines> {
  late Color color;
  late Future<void> _colorState;

  @override
  void initState() {
    super.initState();
    _colorState = _updateColor();
  }

  Future<void> _updateColor() async {
    try {
      final imageProvider = widget.currentNews.urlToImage != null
          ? NetworkImage(widget.currentNews.urlToImage!)
          : const AssetImage('assets/images/placeholder.jpg');
      PaletteGenerator generator = await PaletteGenerator.fromImageProvider(
        imageProvider as ImageProvider<Object>,
        size: const Size(200, 100),
      );
      color = generator.lightMutedColor != null
          ? generator.lightMutedColor!.color
          : Colors.blue;
    } catch (e) {
      color = Colors.black;
    }
    setState(() {});
  }

  Color invert(Color color) {
    final r = 255 - color.red;
    final g = 255 - color.green;
    final b = 255 - color.blue;

    return Color.fromARGB(255, r, g, b);
  }

  @override
  Widget build(BuildContext context) {
    final String? imageUrl = widget.currentNews.urlToImage;
    final imageAvailable = imageUrl != null;
    final headlinesToList = widget.headlineNews
        .where((headline) => headline != widget.currentNews)
        .toList();
    return FutureBuilder(
      future: _colorState,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final fgColor = invert(color);
          return Scaffold(
            body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    backgroundColor: color,
                    foregroundColor: fgColor,
                    floating: true,
                    snap: true,
                    title: const Text(
                      'Headlines',
                    ),
                  )
                ];
              },
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      children: [
                        CustomFadeinImage(
                          height: 250,
                          imageUrl: imageUrl,
                        ),
                        Stack(
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.fromLTRB(16, 16, 16, 48),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    color.withOpacity(1),
                                    color.withOpacity(0),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    widget.currentNews.title ?? '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(fontSize: 24),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    widget.currentNews.description ?? '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => NewsScreen(
                                        url: widget.currentNews.url!,
                                      ),
                                    ),
                                  );
                                },
                                child: const Text('Read full article'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    headlinesToList.isEmpty
                        ? const SizedBox() //to be implemented
                        : Column(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 8, bottom: 4),
                                width: double.infinity,
                                child: Text(
                                  'Top Headlines...',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ),
                              NewsList(
                                allNews: headlinesToList,
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
