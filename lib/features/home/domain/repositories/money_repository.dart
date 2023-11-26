import 'package:dartz/dartz.dart';
import 'package:perfin_app/core/error/failure.dart';
import 'package:perfin_app/features/home/domain/entities/money.dart';

abstract class MoneyRepository {
  Future<Either<Failure, void>> changeMoney(Money money, int newTotal);
}
