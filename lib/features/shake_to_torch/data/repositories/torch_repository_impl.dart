import 'package:flutter/services.dart';
import '../../domain/repositories/torch_repository.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/utils/result.dart';

class TorchRepositoryImpl implements TorchRepository {
  static const _channel = MethodChannel('com.tompvarghese.shake_to_torch/torch');

  @override
  Future<Result<bool, Failure>> getTorchState() async {
    try {
      final bool state = await _channel.invokeMethod('getTorchState');
      return Success(state);
    } catch (e) {
      return Error(SystemFailure('Failed to get torch state: $e'));
    }
  }

  @override
  Future<Result<bool, Failure>> toggleTorch() async {
    try {
      final bool newState = await _channel.invokeMethod('toggleTorch');
      return Success(newState);
    } catch (e) {
      return Error(SystemFailure('Failed to toggle torch: $e'));
    }
  }
}
