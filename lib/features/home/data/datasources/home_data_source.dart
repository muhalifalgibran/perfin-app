import 'package:dartz/dartz.dart';
import 'package:perfin_app/core/error/failure.dart';

import '../../domain/entities/user_x.dart';

abstract class HomeDataSource {
  Future<Either<Failure, UserX>> getCurrentUser(String userId);
}
