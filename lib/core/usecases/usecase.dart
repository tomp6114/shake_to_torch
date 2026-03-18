import 'package:equatable/equatable.dart';

import '../error/failures.dart';
import '../utils/result.dart';

abstract class UseCase<Type, Params> {
  Future<Result<Type, Failure>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
