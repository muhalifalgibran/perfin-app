import 'package:dartz/dartz.dart';
import 'package:perfin_app/core/error/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> createUser(String email, String password);
  Future<Either<Failure, void>> login(String email, String password);
  Future<Either<Failure, bool>> isLoggedIn();
}
