import 'package:dartz/dartz.dart';
import 'package:perfin_app/core/di/service_locator.dart';
import 'package:perfin_app/core/error/failure.dart';
import 'package:perfin_app/features/home/domain/entities/money.dart';
import 'package:perfin_app/features/home/domain/repositories/money_repository.dart';

class ChangeMoney {
  Future<Either<Failure, void>> call(Money money, num newTotal) =>
      getIt<MoneyRepository>().changeMoney(money, newTotal);
}
