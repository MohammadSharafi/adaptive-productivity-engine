import 'failures.dart';

class ErrorHandler {
  static String getUserFriendlyMessage(Failure failure) {
    if (failure is NetworkFailure) {
      return 'No internet connection. Please check your network and try again.';
    }
    
    if (failure is ServerFailure) {
      if (failure.code == '500') {
        return 'Server error. Please try again later.';
      }
      if (failure.code == '404') {
        return 'The requested resource was not found.';
      }
      return failure.message.isNotEmpty 
          ? failure.message 
          : 'Server error. Please try again later.';
    }
    
    if (failure is NotFoundFailure) {
      return 'Resource not found. It may have been deleted.';
    }
    
    if (failure is ValidationFailure) {
      return failure.message.isNotEmpty 
          ? failure.message 
          : 'Invalid input. Please check your data and try again.';
    }
    
    return 'Something went wrong. Please try again.';
  }
  
  static String getErrorTitle(Failure failure) {
    if (failure is NetworkFailure) {
      return 'Connection Error';
    }
    if (failure is ServerFailure) {
      return 'Server Error';
    }
    if (failure is NotFoundFailure) {
      return 'Not Found';
    }
    if (failure is ValidationFailure) {
      return 'Validation Error';
    }
    return 'Error';
  }
  
  static bool isRetryable(Failure failure) {
    return failure is NetworkFailure || 
           (failure is ServerFailure && failure.code != '400' && failure.code != '404');
  }
}

