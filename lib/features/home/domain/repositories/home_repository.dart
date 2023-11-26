import 'package:dartz/dartz.dart';
import 'package:perfin_app/core/error/failure.dart';
import 'package:perfin_app/features/home/domain/entities/money.dart';
import 'package:perfin_app/features/home/domain/entities/user_x.dart';

abstract class HomeRepository {
  Future<Either<Failure, UserX>> getCurrentUser(String userId);
  Future<Either<Failure, List<Money>?>> getUserMoney(String userId);
}
