import 'package:fpdart/fpdart.dart';
import '../../../../../core/error/failures.dart';
import '../entities/shake_sensitivity.dart';

abstract class SettingsRepository {
  Future<Either<Failure, void>> saveSensitivity(ShakeSensitivity sensitivity);
  Future<Either<Failure, ShakeSensitivity>> getSensitivity();
}
