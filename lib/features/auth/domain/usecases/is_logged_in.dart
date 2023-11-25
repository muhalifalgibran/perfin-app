import 'package:dartz/dartz.dart';
import 'package:perfin_app/core/di/service_locator.dart';
import 'package:perfin_app/core/error/failure.dart';
import 'package:perfin_app/features/auth/domain/repositories/auth_repository.dart';

// Determining input to a use case serves as a form of living documentation.
// By looking at the input, developers can easily understand how the use case is
// used and how it should behave. So, even our usecase doesn't need input
// it is better give it still.

class IsLoggedIn {
  final _repo = getIt<AuthRepository>();

  Future<Either<Failure, bool>> isLoggedIn(NoParams params) async =>
      await _repo.isLoggedIn();
}

class NoParams {}
