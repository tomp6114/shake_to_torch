import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/shake_to_torch/data/repositories/sensor_repository_impl.dart';
import '../../features/shake_to_torch/data/repositories/settings_repository_impl.dart';
import '../../features/shake_to_torch/data/repositories/torch_repository_impl.dart';
import '../../features/shake_to_torch/domain/repositories/sensor_repository.dart';
import '../../features/shake_to_torch/domain/repositories/settings_repository.dart';
import '../../features/shake_to_torch/domain/repositories/torch_repository.dart';
import '../../features/shake_to_torch/domain/usecases/get_sensitivity.dart';
import '../../features/shake_to_torch/domain/usecases/listen_to_shake.dart';
import '../../features/shake_to_torch/domain/usecases/toggle_torch.dart';
import '../../features/shake_to_torch/domain/usecases/update_sensitivity.dart';
import '../../features/shake_to_torch/presentation/bloc/shake_torch_bloc.dart';

final getIt = GetIt.instance;

Future<void> initDI() async {
  // Core / External
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);

  // Repositories
  getIt.registerLazySingleton<SettingsRepository>(() => SettingsRepositoryImpl(getIt()));
  getIt.registerLazySingleton<SensorRepository>(() => SensorRepositoryImpl());
  getIt.registerLazySingleton<TorchRepository>(() => TorchRepositoryImpl());

  // UseCases
  getIt.registerLazySingleton(() => GetSensitivityUseCase(getIt()));
  getIt.registerLazySingleton(() => UpdateSensitivityUseCase(getIt(), getIt()));
  getIt.registerLazySingleton(() => ListenToShakeUseCase(getIt()));
  getIt.registerLazySingleton(() => ToggleTorchUseCase(getIt()));

  // BLoC
  getIt.registerFactory(
    () => ShakeTorchBloc(
      getSensitivity: getIt(),
      updateSensitivity: getIt(),
      listenToShake: getIt(),
      toggleTorch: getIt(),
      torchRepository: getIt(),
    ),
  );
}
