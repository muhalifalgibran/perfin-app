import 'package:get_it/get_it.dart';
import 'package:perfin_app/features/auth/data/datasources/auth_data_source.dart';
import 'package:perfin_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:perfin_app/features/auth/domain/repositories/auth_repository.dart';

GetIt getIt = GetIt.instance;

// setup the dependency injection
// since we don't use build_runner to generate the
// service locator, so we defined our classes manually

void setupLocator() {
  // datasources
  getIt.registerLazySingleton<AuthDataSource>(() => AuthDataSourceImpl());

  //repositories
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());
}
