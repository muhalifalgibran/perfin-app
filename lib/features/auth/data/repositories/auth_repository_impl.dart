import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:perfin_app/core/di/service_locator.dart';
import 'package:perfin_app/core/error/failure.dart';
import 'package:perfin_app/core/utils/repository_mixin.dart';
import 'package:perfin_app/features/auth/data/datasources/auth_data_source.dart';
import 'package:perfin_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl with RepositoryMixin implements AuthRepository {
  final _datasource = getIt<AuthDataSource>();
  @override
  Future<Either<Failure, void>> createUser(
          String email, String password) async =>
      await callDataSource(
        () => _datasource.createAccount(email, password),
      );

  @override
  Future<Either<Failure, bool>> isLoggedIn() async =>
      callDataSource(() => _datasource.isLoggedIn());

  @override
  Future<Either<Failure, void>> login(String email, String password) async =>
      await callDataSource(
        () => _datasource.login(email, password),
      );

  @override
  Future<Either<Failure, User?>> getCurrentUser() async =>
      await callDataSource(() => _datasource.getCurrentUser());
}
