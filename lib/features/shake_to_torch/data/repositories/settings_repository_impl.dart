import 'package:shared_preferences/shared_preferences.dart';
import 'package:fpdart/fpdart.dart';
import '../../domain/entities/shake_sensitivity.dart';
import '../../domain/repositories/settings_repository.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SharedPreferences _prefs;
  
  SettingsRepositoryImpl(this._prefs);

  @override
  Future<Either<Failure, ShakeSensitivity>> getSensitivity() async {
    try {
      final value = _prefs.getString('sensitivity') ?? ShakeSensitivity.medium.name;
      final sensitivity = ShakeSensitivity.values.firstWhere(
        (e) => e.name == value, 
        orElse: () => ShakeSensitivity.medium
      );
      return Right(sensitivity);
    } catch (e) {
      return Left(CacheFailure(CacheException('Failed to read settings: $e').toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveSensitivity(ShakeSensitivity sensitivity) async {
    try {
      await _prefs.setString('sensitivity', sensitivity.name);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(CacheException('Failed to save settings: $e').toString()));
    }
  }
}
