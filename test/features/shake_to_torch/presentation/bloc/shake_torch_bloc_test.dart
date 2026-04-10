import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shake_to_torch/core/usecases/usecase.dart';
import 'package:shake_to_torch/features/shake_to_torch/domain/entities/shake_sensitivity.dart';
import 'package:shake_to_torch/features/shake_to_torch/domain/usecases/get_sensitivity.dart';
import 'package:shake_to_torch/features/shake_to_torch/domain/usecases/listen_to_shake.dart';
import 'package:shake_to_torch/features/shake_to_torch/domain/usecases/toggle_torch.dart';
import 'package:shake_to_torch/features/shake_to_torch/domain/usecases/update_sensitivity.dart';
import 'package:shake_to_torch/features/shake_to_torch/domain/repositories/torch_repository.dart';
import 'package:shake_to_torch/features/shake_to_torch/presentation/bloc/shake_torch_bloc.dart';
import 'package:shake_to_torch/features/shake_to_torch/presentation/bloc/shake_torch_event.dart';
import 'package:shake_to_torch/features/shake_to_torch/presentation/bloc/shake_torch_state.dart';

class MockGetSensitivityUseCase extends Mock implements GetSensitivityUseCase {}
class MockUpdateSensitivityUseCase extends Mock implements UpdateSensitivityUseCase {}
class MockListenToShakeUseCase extends Mock implements ListenToShakeUseCase {}
class MockToggleTorchUseCase extends Mock implements ToggleTorchUseCase {}
class MockTorchRepository extends Mock implements TorchRepository {}

void main() {
  late MockGetSensitivityUseCase mockGetSensitivity;
  late MockUpdateSensitivityUseCase mockUpdateSensitivity;
  late MockListenToShakeUseCase mockListenToShake;
  late MockToggleTorchUseCase mockToggleTorch;
  late MockTorchRepository mockTorchRepository;
  late ShakeTorchBloc bloc;

  setUp(() {
    mockGetSensitivity = MockGetSensitivityUseCase();
    mockUpdateSensitivity = MockUpdateSensitivityUseCase();
    mockListenToShake = MockListenToShakeUseCase();
    mockToggleTorch = MockToggleTorchUseCase();
    mockTorchRepository = MockTorchRepository();
    
    bloc = ShakeTorchBloc(
      getSensitivity: mockGetSensitivity,
      updateSensitivity: mockUpdateSensitivity,
      listenToShake: mockListenToShake,
      toggleTorch: mockToggleTorch,
      torchRepository: mockTorchRepository,
    );
  });

  group('LoadSettingsEvent', () {
    blocTest<ShakeTorchBloc, ShakeTorchState>(
      'should emit loaded state completely',
      build: () {
        when(() => mockGetSensitivity(NoParams()))
            .thenAnswer((_) async => const Right(ShakeSensitivity.high));
        when(() => mockTorchRepository.getTorchState())
            .thenAnswer((_) async => const Right(true));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadSettingsEvent()),
      expect: () => [
        ShakeTorchState.initial().copyWith(isLoading: true, errorMessage: null),
        ShakeTorchState.initial().copyWith(sensitivity: ShakeSensitivity.high, isLoading: false, errorMessage: null),
        ShakeTorchState.initial().copyWith(sensitivity: ShakeSensitivity.high, isTorchOn: true, isLoading: false, errorMessage: null),
      ],
    );
  });
}
