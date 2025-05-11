import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/article_view_model.dart';
import '../providers/favorite_view_model.dart';
import '../widgets/article_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final articles = ref.watch(articleViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Articles', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.favorite,
              color: Colors.white,
            ),
            onPressed: () {
              context.go('/favorites');
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              // Theme.of(context).primaryColor.withOpacity(0.8),
              // Theme.of(context).primaryColor.withOpacity(0.4),
              Color(0xFF000000),
              Color(0xFF4B0082),
              Color(0xFF800080),
            ],
          ),
        ),
        child: Consumer(
          builder: (context, ref, child) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Search articles...',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Color(0xFF800080),
                        ),
                      ),
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                    ),
                    controller: _searchController,
                    onChanged: (value) {
                      ref
                          .read(articleViewModelProvider.notifier)
                          .setSearchQuery(_searchController.text);
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async =>
                        ref.read(articleViewModelProvider.notifier).refresh(),
                    child: Consumer(
                      builder: (context, ref, child) {
                        final favorites = ref.watch(favoriteViewModelProvider);
                        return articles.when(
                          data: (articles) {
                            final filteredArticles = articles;
                            if (filteredArticles.isEmpty) {
                              return Center(
                                child: Text(
                                  'No Result Found for "${_searchController.text}"',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          color: Colors.white, fontSize: 18),
                                ),
                              );
                            }
                            return ListView.builder(
                              itemCount: filteredArticles.length,
                              itemBuilder: (context, index) {
                                final article = filteredArticles[index];
                                return ArticleCard(
                                  article: article,
                                  isFavorite: favorites
                                      .any((fav) => fav.id == article.id),
                                  onFavoritePressed: () {
                                    ref
                                        .read(
                                            favoriteViewModelProvider.notifier)
                                        .toggleFavorite(article);
                                  },
                                  onTap: () {
                                    context.push(
                                      '/article',
                                      extra: {
                                        'id': article.id,
                                        'userId': article.userId,
                                        'title': article.title,
                                        'body': article.body,
                                      },
                                    );
                                  },
                                );
                              },
                            );
                          },
                          loading: () =>
                              const Center(child: CircularProgressIndicator()),
                          error: (error, stackTrace) => const Center(
                            child:
                                Text('Something went wrong fetching articles'),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
