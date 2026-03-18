import 'package:equatable/equatable.dart';
import '../../domain/entities/shake_sensitivity.dart';

class ShakeTorchState extends Equatable {
  final bool isServiceActive;
  final bool isTorchOn;
  final ShakeSensitivity sensitivity;
  final String? errorMessage;
  final bool isLoading;

  const ShakeTorchState({
    required this.isServiceActive,
    required this.isTorchOn,
    required this.sensitivity,
    this.errorMessage,
    required this.isLoading,
  });

  factory ShakeTorchState.initial() {
    return const ShakeTorchState(
      isServiceActive: false,
      isTorchOn: false,
      sensitivity: ShakeSensitivity.medium,
      isLoading: true,
    );
  }

  ShakeTorchState copyWith({
    bool? isServiceActive,
    bool? isTorchOn,
    ShakeSensitivity? sensitivity,
    String? errorMessage,
    bool? isLoading,
  }) {
    return ShakeTorchState(
      isServiceActive: isServiceActive ?? this.isServiceActive,
      isTorchOn: isTorchOn ?? this.isTorchOn,
      sensitivity: sensitivity ?? this.sensitivity,
      errorMessage: errorMessage, // Reset error message if not provided explicitly? Or keep it? Usually reset to null.
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [isServiceActive, isTorchOn, sensitivity, errorMessage, isLoading];
}
