class ServerException implements Exception {}

class CacheException implements Exception {}

class NetworkException implements Exception {}

class ConflictException implements Exception {}

class ValidationException implements Exception {
  final String message;

  ValidationException(this.message);
}