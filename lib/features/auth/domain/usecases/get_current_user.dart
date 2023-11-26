import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:perfin_app/core/di/service_locator.dart';
import 'package:perfin_app/core/error/failure.dart';
import 'package:perfin_app/features/auth/domain/repositories/auth_repository.dart';

class GetCurrentUser {
  final _repo = getIt<AuthRepository>();

  Future<Either<Failure, User?>> call(NoParams params) async =>
      await _repo.getCurrentUser();
}

class NoParams {}
