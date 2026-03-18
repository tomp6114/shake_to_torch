import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../../../core/utils/result.dart';
import '../repositories/sensor_repository.dart';

class ListenToShakeUseCase {
  final SensorRepository repository;

  ListenToShakeUseCase(this.repository);

  Stream<void> get shakeEvents => repository.shakeEvents;

  Future<Result<void, Failure>> start() async {
    try {
      await repository.startListening();
      return const Success(null);
    } catch (e) {
      return Error(SystemFailure(e.toString()));
    }
  }

  Future<Result<void, Failure>> stop() async {
    try {
      await repository.stopListening();
      return const Success(null);
    } catch (e) {
      return Error(SystemFailure(e.toString()));
    }
  }
}
