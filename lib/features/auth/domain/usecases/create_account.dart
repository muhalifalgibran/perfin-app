import 'package:dartz/dartz.dart';
import 'package:perfin_app/core/di/service_locator.dart';
import 'package:perfin_app/core/error/failure.dart';
import 'package:perfin_app/features/auth/domain/repositories/auth_repository.dart';

class CreateAccount {
  final _repo = getIt<AuthRepository>();

  Future<Either<Failure, void>> call(String email, String password) async =>
      await _repo.createUser(email, password);
}
