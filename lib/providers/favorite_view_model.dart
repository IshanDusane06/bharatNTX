import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../models/article.dart';

class FavoriteViewModel extends StateNotifier<List<Article>> {
  FavoriteViewModel() : super([]) {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final box = await Hive.openBox<Article>('favorites');
    state = box.values.toList();
  }

  Future<void> toggleFavorite(Article article) async {
    if (isFavorite(article)) {
      await _removeFavorite(article);
    } else {
      await _addFavorite(article);
    }
  }

  bool isFavorite(Article article) {
    return state.any((fav) => fav.id == article.id);
  }

  Future<void> _addFavorite(Article article) async {
    final box = await Hive.openBox<Article>('favorites');
    await box.add(article);
    state = [...state, article];
  }

  Future<void> _removeFavorite(Article article) async {
    final box = await Hive.openBox<Article>('favorites');
    final key = box.keys.firstWhere(
      (key) => box.get(key)?.id == article.id,
      orElse: () => -1,
    );
    if (key != -1) {
      await box.delete(key);
      state = state.where((fav) => fav.id != article.id).toList();
    }
  }
}

final favoriteViewModelProvider = StateNotifierProvider<FavoriteViewModel, List<Article>>((ref) {
  return FavoriteViewModel();
});
