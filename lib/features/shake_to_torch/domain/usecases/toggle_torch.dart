import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../../../core/utils/result.dart';
import '../repositories/torch_repository.dart';

class ToggleTorchUseCase implements UseCase<bool, NoParams> {
  final TorchRepository repository;

  ToggleTorchUseCase(this.repository);

  @override
  Future<Result<bool, Failure>> call(NoParams params) {
    return repository.toggleTorch();
  }
}
