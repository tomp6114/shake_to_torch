import '../../../../../core/error/failures.dart';
import '../../../../../core/utils/result.dart';
import '../entities/shake_sensitivity.dart';

abstract class SettingsRepository {
  Future<Result<void, Failure>> saveSensitivity(ShakeSensitivity sensitivity);
  Future<Result<ShakeSensitivity, Failure>> getSensitivity();
}
