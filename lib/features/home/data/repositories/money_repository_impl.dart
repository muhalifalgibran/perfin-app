import 'package:dartz/dartz.dart';
import 'package:perfin_app/core/di/service_locator.dart';
import 'package:perfin_app/core/error/failure.dart';
import 'package:perfin_app/core/utils/repository_mixin.dart';
import 'package:perfin_app/features/home/data/datasources/money_data_source.dart';
import 'package:perfin_app/features/home/domain/entities/money.dart';
import 'package:perfin_app/features/home/domain/repositories/money_repository.dart';

class MoneyRepositoryImpl with RepositoryMixin implements MoneyRepository {
  @override
  Future<Either<Failure, void>> changeMoney(Money money, num newTotal) {
    return callDataSource(
      () => getIt<MoneyDataSource>().changeMoney(money, newTotal),
    );
  }
}
