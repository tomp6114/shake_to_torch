import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'shake_torch_event.dart';
import 'shake_torch_state.dart';
import '../../domain/usecases/get_sensitivity.dart';
import '../../domain/usecases/update_sensitivity.dart';
import '../../domain/usecases/listen_to_shake.dart';
import '../../domain/usecases/toggle_torch.dart';
import '../../domain/repositories/torch_repository.dart';
import '../../../../core/usecases/usecase.dart';

class ShakeTorchBloc extends Bloc<ShakeTorchEvent, ShakeTorchState> {
  final GetSensitivityUseCase getSensitivity;
  final UpdateSensitivityUseCase updateSensitivity;
  final ListenToShakeUseCase listenToShake;
  final ToggleTorchUseCase toggleTorch;
  final TorchRepository torchRepository;
  
  StreamSubscription? _shakeSubscription;

  ShakeTorchBloc({
    required this.getSensitivity,
    required this.updateSensitivity,
    required this.listenToShake,
    required this.toggleTorch,
    required this.torchRepository,
  }) : super(ShakeTorchState.initial()) {
    on<LoadSettingsEvent>(_onLoadSettings);
    on<ToggleServiceEvent>(_onToggleService);
    on<SensitivityChangedEvent>(_onSensitivityChanged);
    on<ShakeDetectedEvent>(_onShakeDetected);
    on<SyncTorchStateEvent>(_onSyncTorchState);
  }

  Future<void> _onLoadSettings(LoadSettingsEvent event, Emitter<ShakeTorchState> emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    final result = await getSensitivity(NoParams());
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.message, isLoading: false)),
      (sensitivity) => emit(state.copyWith(sensitivity: sensitivity, isLoading: false)),
    );
    add(SyncTorchStateEvent());
  }

  Future<void> _onToggleService(ToggleServiceEvent event, Emitter<ShakeTorchState> emit) async {
    if (event.enable) {
      final startResult = await listenToShake.start();
      startResult.fold(
        (failure) => emit(state.copyWith(errorMessage: failure.message)),
        (_) {
          _shakeSubscription?.cancel();
          _shakeSubscription = listenToShake.shakeEvents.listen((_) {
            add(ShakeDetectedEvent());
          });
          emit(state.copyWith(isServiceActive: true, errorMessage: null));
        },
      );
    } else {
      await _shakeSubscription?.cancel();
      _shakeSubscription = null;
      await listenToShake.stop();
      emit(state.copyWith(isServiceActive: false, errorMessage: null));
    }
  }

  Future<void> _onSensitivityChanged(SensitivityChangedEvent event, Emitter<ShakeTorchState> emit) async {
    final result = await updateSensitivity(event.sensitivity);
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.message)),
      (_) => emit(state.copyWith(sensitivity: event.sensitivity, errorMessage: null)),
    );
  }

  Future<void> _onShakeDetected(ShakeDetectedEvent event, Emitter<ShakeTorchState> emit) async {
    final result = await toggleTorch(NoParams());
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.message)),
      (isOn) => emit(state.copyWith(isTorchOn: isOn, errorMessage: null)),
    );
  }

  Future<void> _onSyncTorchState(SyncTorchStateEvent event, Emitter<ShakeTorchState> emit) async {
    final result = await torchRepository.getTorchState();
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.message)),
      (isOn) => emit(state.copyWith(isTorchOn: isOn, errorMessage: null)),
    );
  }

  @override
  Future<void> close() {
    _shakeSubscription?.cancel();
    return super.close();
  }
}
