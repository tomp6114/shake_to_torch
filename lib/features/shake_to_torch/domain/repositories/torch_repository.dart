import 'package:fpdart/fpdart.dart';
import '../../../../../core/error/failures.dart';

abstract class TorchRepository {
  /// Toggles the torch state. Returns the new state (true if ON, false if OFF)
  Future<Either<Failure, bool>> toggleTorch();

  /// Returns current torch state
  Future<Either<Failure, bool>> getTorchState();
}
