import 'package:equatable/equatable.dart';
import '../../domain/entities/shake_sensitivity.dart';

abstract class ShakeTorchEvent extends Equatable {
  const ShakeTorchEvent();

  @override
  List<Object> get props => [];
}

class LoadSettingsEvent extends ShakeTorchEvent {}

class ToggleServiceEvent extends ShakeTorchEvent {
  final bool enable;
  const ToggleServiceEvent(this.enable);

  @override
  List<Object> get props => [enable];
}

class SensitivityChangedEvent extends ShakeTorchEvent {
  final ShakeSensitivity sensitivity;
  const SensitivityChangedEvent(this.sensitivity);

  @override
  List<Object> get props => [sensitivity];
}

class ShakeDetectedEvent extends ShakeTorchEvent {}

class SyncTorchStateEvent extends ShakeTorchEvent {}
