import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zena_foru/providers/http_fetch_provider.dart';
import 'package:zena_foru/widgets/empty_list.dart';
import 'package:zena_foru/widgets/news_list.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  Future<void>? _searchState;
  final _controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  _search() {
    if (_controller.value.text.trim().isEmpty) {
      return;
    }
    setState(() {
      _searchState = ref.read(apisFetchProvider.notifier).fetchAPIsData(
            everythingsQuery: '"${_controller.value.text.trim()}"',
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.8),
                    width: 0.3,
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          hintText: 'Search Here...',
                          enabledBorder: null,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: _search,
                      icon: const Icon(
                        Icons.search,
                      ),
                    ),
                  ],
                ),
              ),
              FutureBuilder(
                future: _searchState,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.connectionState == ConnectionState.none) {
                    return const EmptyList();
                  } else {
                    final newsFromSearch = ref.watch(allNewsProvider);
                    return newsFromSearch == null || newsFromSearch.isEmpty
                        ? const Center(
                            child: Text('No result!'),
                          )
                        : NewsList(allNews: newsFromSearch);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
