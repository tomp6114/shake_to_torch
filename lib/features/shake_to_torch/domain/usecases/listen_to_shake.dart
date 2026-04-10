import 'package:fpdart/fpdart.dart';
import '../../../../../core/error/failures.dart';
import '../repositories/sensor_repository.dart';

class ListenToShakeUseCase {
  final SensorRepository repository;

  ListenToShakeUseCase(this.repository);

  Stream<void> get shakeEvents => repository.shakeEvents;

  Future<Either<Failure, void>> start() async {
    try {
      await repository.startListening();
      return const Right(null);
    } catch (e) {
      return Left(SystemFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> stop() async {
    try {
      await repository.stopListening();
      return const Right(null);
    } catch (e) {
      return Left(SystemFailure(e.toString()));
    }
  }
}
