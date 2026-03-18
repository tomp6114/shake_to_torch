import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../../../core/utils/result.dart';
import '../entities/shake_sensitivity.dart';
import '../repositories/settings_repository.dart';

class GetSensitivityUseCase implements UseCase<ShakeSensitivity, NoParams> {
  final SettingsRepository repository;

  GetSensitivityUseCase(this.repository);

  @override
  Future<Result<ShakeSensitivity, Failure>> call(NoParams params) {
    return repository.getSensitivity();
  }
}
