/// Base class for all use cases
/// Type - Return type of the use case
/// Params - Parameters needed to execute the use case
abstract class UseCase<Type, Params> {
  Future<Type> call(Params params);
}

/// Use case that doesn't require parameters
abstract class NoParamsUseCase<Type> {
  Future<Type> call();
}