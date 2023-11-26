import 'package:dartz/dartz.dart';
import 'package:perfin_app/core/di/service_locator.dart';
import 'package:perfin_app/core/error/failure.dart';
import 'package:perfin_app/features/home/domain/entities/money.dart';
import 'package:perfin_app/features/home/domain/repositories/home_repository.dart';

class GetUserMoney {
  Future<Either<Failure, List<Money>?>> call(String userId) =>
      getIt<HomeRepository>().getUserMoney(userId);
}
