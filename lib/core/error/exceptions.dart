abstract class AppException implements Exception {
  final String message;
  const AppException(this.message);

  @override
  String toString() => message;
}

class NativeSensorException extends AppException {
  const NativeSensorException([super.message = 'Failed to interact with native sensor bridge.']);
}

class TorchException extends AppException {
  const TorchException([super.message = 'Failed to trigger torch.']);
}

class CacheException extends AppException {
  const CacheException([super.message = 'Failed to read/write from local cache.']);
}
