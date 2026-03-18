import '../../../../../core/error/failures.dart';
import '../../../../../core/utils/result.dart';

abstract class TorchRepository {
  /// Toggles the torch state. Returns the new state (true if ON, false if OFF)
  Future<Result<bool, Failure>> toggleTorch();

  /// Returns current torch state
  Future<Result<bool, Failure>> getTorchState();
}
