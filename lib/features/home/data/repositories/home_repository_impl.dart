import 'package:dartz/dartz.dart';
import 'package:perfin_app/core/di/service_locator.dart';
import 'package:perfin_app/core/error/failure.dart';
import 'package:perfin_app/core/utils/repository_mixin.dart';
import 'package:perfin_app/features/home/data/datasources/home_data_source.dart';
import 'package:perfin_app/features/home/domain/entities/money.dart';
import 'package:perfin_app/features/home/domain/entities/user_x.dart';
import 'package:perfin_app/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl with RepositoryMixin implements HomeRepository {
  final _dataSource = getIt<HomeDataSource>();
  @override
  Future<Either<Failure, UserX>> getCurrentUser(String userId) =>
      callDataSource(() => _dataSource.getCurrentUser(userId));

  @override
  Future<Either<Failure, List<Money>?>> getUserMoney(String userId) =>
      callDataSource(() => _dataSource.getCurrentUserMoney(userId));

  @override
  Future<Either<Failure, void>> signOut() =>
      callDataSource(() => _dataSource.logout());
}
