import 'package:dartz/dartz.dart';
import 'package:smart_wear/src/core/failure.dart';

abstract class UseCase<Type, Params> {
  Either<Failure, Type> call(Params params);
}
abstract class FutureUseCase<Type, Params> {
  Future<Either<Failure,Type>> call(Params params);
}

class NoParams {}