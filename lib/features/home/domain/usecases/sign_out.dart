import 'package:dartz/dartz.dart';
import 'package:perfin_app/core/di/service_locator.dart';
import 'package:perfin_app/core/error/failure.dart';
import 'package:perfin_app/features/home/domain/repositories/home_repository.dart';

class SignOut {
  Future<Either<Failure, void>> call() => getIt<HomeRepository>().signOut();
}
