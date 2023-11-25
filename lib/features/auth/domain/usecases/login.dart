import 'package:dartz/dartz.dart';
import 'package:perfin_app/core/di/service_locator.dart';
import 'package:perfin_app/core/error/failure.dart';
import 'package:perfin_app/features/auth/domain/repositories/auth_repository.dart';

class Login {
  final _repo = getIt<AuthRepository>();

  Future<Either<Failure, void>> login(String email, String password) async =>
      _repo.login(email, password);
}
