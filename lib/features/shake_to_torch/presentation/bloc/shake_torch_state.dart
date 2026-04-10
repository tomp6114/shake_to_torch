import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/shake_sensitivity.dart';

part 'shake_torch_state.freezed.dart';

@freezed
class ShakeTorchState with _$ShakeTorchState {
  const factory ShakeTorchState({
    @Default(ShakeSensitivity.medium) ShakeSensitivity sensitivity,
    @Default(false) bool isTorchOn,
    @Default(false) bool isServiceActive,
    @Default(false) bool isLoading,
    String? errorMessage,
  }) = _ShakeTorchState;

  factory ShakeTorchState.initial() => const ShakeTorchState();
}
