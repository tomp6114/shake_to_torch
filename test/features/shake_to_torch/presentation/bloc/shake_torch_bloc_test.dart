import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shake_to_torch/features/shake_to_torch/domain/entities/shake_sensitivity.dart';
import 'package:shake_to_torch/features/shake_to_torch/domain/usecases/get_sensitivity.dart';
import 'package:shake_to_torch/features/shake_to_torch/domain/usecases/update_sensitivity.dart';
import 'package:shake_to_torch/features/shake_to_torch/domain/usecases/listen_to_shake.dart';
import 'package:shake_to_torch/features/shake_to_torch/domain/usecases/toggle_torch.dart';
import 'package:shake_to_torch/features/shake_to_torch/domain/repositories/torch_repository.dart';
import 'package:shake_to_torch/features/shake_to_torch/presentation/bloc/shake_torch_bloc.dart';
import 'package:shake_to_torch/features/shake_to_torch/presentation/bloc/shake_torch_event.dart';
import 'package:shake_to_torch/features/shake_to_torch/presentation/bloc/shake_torch_state.dart';
import 'package:shake_to_torch/core/usecases/usecase.dart';
import 'package:shake_to_torch/core/utils/result.dart';

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

    // Register fallback parameter
    registerFallbackValue(NoParams());
    registerFallbackValue(ShakeSensitivity.medium);

    bloc = ShakeTorchBloc(
      getSensitivity: mockGetSensitivity,
      updateSensitivity: mockUpdateSensitivity,
      listenToShake: mockListenToShake,
      toggleTorch: mockToggleTorch,
      torchRepository: mockTorchRepository,
    );
  });

  tearDown(() {
    bloc.close();
  });

  test('initial state should be ShakeTorchState.initial()', () {
    expect(bloc.state, equals(ShakeTorchState.initial()));
  });

  blocTest<ShakeTorchBloc, ShakeTorchState>(
    'emits state with sensitivity when LoadSettingsEvent is added',
    build: () {
      when(() => mockGetSensitivity(any()))
          .thenAnswer((_) async => const Success(ShakeSensitivity.high));
      when(() => mockTorchRepository.getTorchState())
          .thenAnswer((_) async => const Success(false)); // Mock for Sync
      return bloc;
    },
    act: (bloc) => bloc.add(LoadSettingsEvent()),
    expect: () => [
      ShakeTorchState.initial().copyWith(isLoading: true),
      ShakeTorchState.initial().copyWith(isLoading: false, sensitivity: ShakeSensitivity.high),
    ],
  );

  blocTest<ShakeTorchBloc, ShakeTorchState>(
    'emits state with updated sensitivity when SensitivityChangedEvent is added',
    build: () {
      when(() => mockUpdateSensitivity(any()))
          .thenAnswer((_) async => const Success(null));
      return bloc;
    },
    act: (bloc) => bloc.add(const SensitivityChangedEvent(ShakeSensitivity.low)),
    expect: () => [
      ShakeTorchState.initial().copyWith(sensitivity: ShakeSensitivity.low),
    ],
  );

  blocTest<ShakeTorchBloc, ShakeTorchState>(
    'emits state with isTorchOn when ShakeDetectedEvent is added',
    build: () {
      when(() => mockToggleTorch(any()))
          .thenAnswer((_) async => const Success(true));
      return bloc;
    },
    act: (bloc) => bloc.add(ShakeDetectedEvent()),
    expect: () => [
      ShakeTorchState.initial().copyWith(isTorchOn: true),
    ],
  );
}
