import 'package:fpdart/fpdart.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../repositories/torch_repository.dart';

class ToggleTorchUseCase implements UseCase<bool, NoParams> {
  final TorchRepository repository;

  ToggleTorchUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) {
    return repository.toggleTorch();
  }
}
