import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/article.dart';
import '../service/article_repository.dart';

class ArticleViewModel extends StateNotifier<AsyncValue<List<Article>>> {
  final ArticleRepository _repository;

  ArticleViewModel(this._repository) : super(const AsyncValue.loading()) {
    _fetchArticles();
  }

  String _searchQuery = '';
  List<Article>? _originalArticles;

  Future<void> _fetchArticles() async {
    state = const AsyncValue.loading();
    try {
      final articles = await _repository.fetchArticles();
      _originalArticles = articles;
      state = AsyncValue.data(articles);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> refresh() async {
    await _fetchArticles();
  }

  Future<Article> getArticle(int id) async {
    try {
      return await _repository.fetchArticle(id);
    } catch (e) {
      throw Exception('Error fetching article: $e');
    }
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    _updateSearchResults();
  }

  void _updateSearchResults() {
    final articles = _originalArticles ?? state.value ?? [];
    if (_searchQuery.isEmpty) {
      state = AsyncValue.data(_originalArticles ?? []);
      return;
    }

    final filteredArticles = _originalArticles?.where((article) {
      final title = article.title.toLowerCase();
      final body = article.body.toLowerCase();
      final searchQuery = _searchQuery.toLowerCase();
      return title.contains(searchQuery) || body.contains(searchQuery);
    }).toList();

    state = AsyncValue.data(filteredArticles ?? []);
  }
}

final articleViewModelProvider =
    StateNotifierProvider<ArticleViewModel, AsyncValue<List<Article>>>((ref) {
  return ArticleViewModel(ref.watch(articleRepositoryProvider));
});
