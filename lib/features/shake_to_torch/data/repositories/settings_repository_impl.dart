import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/shake_sensitivity.dart';
import '../../domain/repositories/settings_repository.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/utils/result.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SharedPreferences _prefs;
  
  SettingsRepositoryImpl(this._prefs);

  @override
  Future<Result<ShakeSensitivity, Failure>> getSensitivity() async {
    try {
      final value = _prefs.getString('sensitivity') ?? ShakeSensitivity.medium.name;
      final sensitivity = ShakeSensitivity.values.firstWhere(
        (e) => e.name == value, 
        orElse: () => ShakeSensitivity.medium
      );
      return Success(sensitivity);
    } catch (e) {
      return Error(CacheFailure('Failed to read settings: $e'));
    }
  }

  @override
  Future<Result<void, Failure>> saveSensitivity(ShakeSensitivity sensitivity) async {
    try {
      await _prefs.setString('sensitivity', sensitivity.name);
      return const Success(null);
    } catch (e) {
      return Error(CacheFailure('Failed to save settings: $e'));
    }
  }
}
