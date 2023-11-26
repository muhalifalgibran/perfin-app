import 'package:dartz/dartz.dart';
import 'package:perfin_app/core/di/service_locator.dart';
import 'package:perfin_app/core/error/failure.dart';
import 'package:perfin_app/features/home/domain/entities/user_x.dart';
import 'package:perfin_app/features/home/domain/repositories/home_repository.dart';

class GetCurrentUser {
  Future<Either<Failure, UserX>> call(String userId) =>
      getIt<HomeRepository>().getCurrentUser(userId);
}
