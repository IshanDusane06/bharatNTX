import 'package:go_router/go_router.dart';
import '../views/home_screen.dart';
import '../views/article_detail_screen.dart';
import '../views/favorites_screen.dart';
import '../models/article.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            path: 'article',
            builder: (context, state) {
              final id = (state.extra as Map)['id'];
              final userId = (state.extra as Map)['userId'];
              final title = (state.extra as Map)['title'];
              final body = (state.extra as Map)['body'];

              return ArticleDetailScreen(
                article: Article(
                  id: id,
                  title: title,
                  body: body,
                  userId: userId,
                ),
              );
            },
          ),
          GoRoute(
            path: 'favorites',
            builder: (context, state) => const FavoritesScreen(),
          ),
        ],
      ),
    ],
  );
}
