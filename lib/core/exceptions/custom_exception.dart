abstract class AppException implements Exception {
  final String message;
  final String? prefix;

  const AppException(this.message, [this.prefix]);

  @override
  String toString() => '$prefix$message';
}

class NetworkException extends AppException {
  const NetworkException([String message = 'Network error occurred'])
      : super(message, 'NetworkException: ');
}

class ServerException extends AppException {
  const ServerException([String message = 'Server error occurred'])
      : super(message, 'ServerException: ');
}

class CacheException extends AppException {
  const CacheException([String message = 'Cache error occurred'])
      : super(message, 'CacheException: ');
}

class UnauthorizedException extends AppException {
  const UnauthorizedException([String message = 'Unauthorized access'])
      : super(message, 'UnauthorizedException: ');
}
