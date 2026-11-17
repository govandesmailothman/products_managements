/// Abstract generic base UseCase interface following Clean Architecture principles.
abstract class UseCase<Type, Params> {
  Future<Type> call(Params params);
}

/// Represents no parameters required for a use case execution.
class NoParams {
  const NoParams();
}
