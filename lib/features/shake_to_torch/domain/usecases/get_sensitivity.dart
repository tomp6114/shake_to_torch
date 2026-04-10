import 'package:fpdart/fpdart.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../entities/shake_sensitivity.dart';
import '../repositories/settings_repository.dart';

class GetSensitivityUseCase implements UseCase<ShakeSensitivity, NoParams> {
  final SettingsRepository repository;

  GetSensitivityUseCase(this.repository);

  @override
  Future<Either<Failure, ShakeSensitivity>> call(NoParams params) {
    return repository.getSensitivity();
  }
}
