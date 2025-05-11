import 'package:dio/dio.dart';
import 'package:bharat_demo/models/article.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bharat_demo/core/exceptions/custom_exception.dart';

final articleRepositoryProvider = Provider<ArticleRepository>((ref) {
  return ArticleRepository();
});

class ArticleRepository {
  final Dio _dio;
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';

  ArticleRepository({Dio? dio})
      : _dio = dio ??
            Dio(BaseOptions(
              baseUrl: _baseUrl,
              connectTimeout: const Duration(seconds: 5),
              receiveTimeout: const Duration(seconds: 3),
            ));

  Future<List<Article>> fetchArticles() async {
    try {
      final response = await _dio.get('/posts');

      if (response.statusCode == 200) {
        try {
          final List<dynamic> data = response.data;
          return data
              .map((json) => Article.fromJson(json as Map<String, dynamic>))
              .toList();
        } catch (e) {
          throw const ServerException('Invalid server response format');
        }
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        throw const UnauthorizedException('Please login to continue');
      } else if (response.statusCode! >= 500) {
        throw const ServerException('Server is currently unavailable');
      } else {
        throw const ServerException('Failed to load articles');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw const NetworkException(
            'Connection timeout. Please check your internet connection.');
      } else if (e.type == DioExceptionType.connectionError) {
        throw const NetworkException('No internet connection');
      } else if (e.response != null) {
        final statusCode = e.response?.statusCode;
        if (statusCode == 401 || statusCode == 403) {
          throw const UnauthorizedException('Please login to continue');
        } else if (statusCode == 404) {
          throw const ServerException('Resource not found');
        } else if (statusCode != null && statusCode >= 500) {
          throw const ServerException('Server error occurred');
        } else {
          throw ServerException(
              e.response?.statusMessage ?? 'An error occurred');
        }
      } else {
        throw NetworkException(e.message ?? 'Network error occurred');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<Article> fetchArticle(int id) async {
    try {
      final response = await _dio.get('/posts/$id');

      if (response.statusCode == 200) {
        try {
          return Article.fromJson(response.data as Map<String, dynamic>);
        } catch (e) {
          throw const ServerException('Invalid article data format');
        }
      } else if (response.statusCode == 404) {
        throw const ServerException('Article not found');
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        throw const UnauthorizedException('Please login to view this article');
      } else if (response.statusCode! >= 500) {
        throw const ServerException('Server is currently unavailable');
      } else {
        throw const ServerException('Failed to load article');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw const NetworkException(
            'Connection timeout. Please check your internet connection.');
      } else if (e.type == DioExceptionType.connectionError) {
        throw const NetworkException('No internet connection');
      } else if (e.response != null) {
        final statusCode = e.response?.statusCode;
        if (statusCode == 401 || statusCode == 403) {
          throw const UnauthorizedException(
              'Please login to view this article');
        } else if (statusCode == 404) {
          throw const ServerException('Article not found');
        } else if (statusCode != null && statusCode >= 500) {
          throw const ServerException('Server error occurred');
        } else {
          throw ServerException(
              e.response?.statusMessage ?? 'Failed to load article');
        }
      } else {
        throw NetworkException(e.message ?? 'Network error occurred');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
