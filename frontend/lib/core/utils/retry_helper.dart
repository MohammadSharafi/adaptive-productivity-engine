import 'dart:async';

class RetryHelper {
  static Future<T> retry<T>({
    required Future<T> Function() operation,
    int maxRetries = 3,
    Duration delay = const Duration(seconds: 1),
    bool Function(Object)? retryIf,
  }) async {
    int attempts = 0;
    
    while (attempts < maxRetries) {
      try {
        return await operation();
      } catch (e) {
        attempts++;
        
        if (retryIf != null && !retryIf(e)) {
          rethrow;
        }
        
        if (attempts >= maxRetries) {
          rethrow;
        }
        
        await Future.delayed(delay * attempts);
      }
    }
    
    throw Exception('Max retries ($maxRetries) exceeded');
  }
}

