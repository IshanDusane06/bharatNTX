import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/article.dart';
import '../providers/article_view_model.dart';
import '../providers/favorite_view_model.dart';

class ArticleDetailScreen extends ConsumerWidget {
  final Article? article;

  const ArticleDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Article Detail',
        ),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: IconButton(
              icon: Icon(
                ref
                        .watch(favoriteViewModelProvider)
                        .any((fav) => fav.id == article?.id)
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: Colors.white,
              ),
              onPressed: () {
                ref
                    .read(articleViewModelProvider.notifier)
                    .getArticle(article?.id ?? -1)
                    .then((article) {
                  ref
                      .read(favoriteViewModelProvider.notifier)
                      .toggleFavorite(article);
                });
              },
            ),
          ),
        ],
      ),
      body: article?.id == -1
          ? const Center(
              child: Text(
                'Something went wrong while loading the article',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            )
          : SafeArea(
              child: Container(
                height: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      // Theme.of(context).primaryColor.withOpacity(0.8),
                      // Theme.of(context).primaryColor.withOpacity(0.4),
                      Color(0xFF000000), // Pure black
                      Color(0xFF4B0082), // Indigo
                      Color(0xFF800080),
                    ],
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              article?.title ?? '',
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                height: 1.4,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              article?.body ?? '',
                              style: const TextStyle(
                                fontSize: 16,
                                height: 1.6,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
