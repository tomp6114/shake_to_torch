import 'package:fpdart/fpdart.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../entities/shake_sensitivity.dart';
import '../repositories/sensor_repository.dart';
import '../repositories/settings_repository.dart';

class UpdateSensitivityUseCase implements UseCase<void, ShakeSensitivity> {
  final SettingsRepository settingsRepository;
  final SensorRepository sensorRepository;

  UpdateSensitivityUseCase(this.settingsRepository, this.sensorRepository);

  @override
  Future<Either<Failure, void>> call(ShakeSensitivity params) async {
    final result = await settingsRepository.saveSensitivity(params);
    
    return result.fold(
      (failure) => Left(failure),
      (_) {
        // Immediate update avoids requiring a sensor service restart
        sensorRepository.setSensitivity(params);
        return const Right(null);
      },
    );
  }
}
