/// A custom Result type for modern Dart 3 error handling, replacing dartz.
sealed class Result<S, E> {
  const Result();

  /// Functional fold to handle Success or Failure streams.
  T fold<T>(T Function(S) onSuccess, T Function(E) onFailure) {
    if (this is Success<S, E>) {
      return onSuccess((this as Success<S, E>).value);
    } else if (this is Error<S, E>) {
      return onFailure((this as Error<S, E>).error);
    }
    throw StateError('Unknown Result type');
  }
}

class Success<S, E> extends Result<S, E> {
  final S value;
  const Success(this.value);
}

class Error<S, E> extends Result<S, E> {
  final E error;
  const Error(this.error);
}
