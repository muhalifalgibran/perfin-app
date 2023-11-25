import 'package:dartz/dartz.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:perfin_app/core/error/failure.dart';

// use mixin to reduce the boilerplate code in repository
mixin RepositoryMixin {
  Future<Either<Failure, T>> callDataSource<T>(
    Future<T> Function() call,
  ) async {
    try {
      return Right(await call());
    } on FirebaseException catch (e) {
      return Left(ClientFailure(message: e.toString()));
    } catch (e) {
      return const Left(
        DeviceFailure(
          message: "Error occures. Try again later",
        ),
      );
    }
  }
}
