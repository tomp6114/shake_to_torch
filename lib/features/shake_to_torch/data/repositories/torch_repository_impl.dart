import 'package:flutter/services.dart';
import 'package:fpdart/fpdart.dart';
import '../../domain/repositories/torch_repository.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';

class TorchRepositoryImpl implements TorchRepository {
  static const _channel = MethodChannel('com.tompvarghese.shake_to_torch/torch');

  @override
  Future<Either<Failure, bool>> getTorchState() async {
    try {
      final bool state = await _channel.invokeMethod('getTorchState');
      return Right(state);
    } catch (e) {
      return Left(SystemFailure(TorchException('Failed to get torch state: $e').toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> toggleTorch() async {
    try {
      final bool newState = await _channel.invokeMethod('toggleTorch');
      return Right(newState);
    } catch (e) {
      return Left(SystemFailure(TorchException('Failed to toggle torch: $e').toString()));
    }
  }
}
