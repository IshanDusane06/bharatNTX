import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:bharat_demo/providers/favorite_view_model.dart';
import 'package:bharat_demo/widgets/article_card.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoriteViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Favorites',
          style: TextStyle(color: Colors.white),
        ),
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
        child: favorites.isEmpty
            ? const Center(
                child: Text('No favorites yet'),
              )
            : ListView.builder(
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  final article = favorites[index];
                  return ArticleCard(
                    article: article,
                    isFavorite: true,
                    onFavoritePressed: () {
                      ref
                          .read(favoriteViewModelProvider.notifier)
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
              ),
      ),
    );
  }
}
