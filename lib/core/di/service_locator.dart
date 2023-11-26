import 'package:get_it/get_it.dart';
import 'package:perfin_app/features/auth/data/datasources/auth_data_source.dart';
import 'package:perfin_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:perfin_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:perfin_app/features/auth/domain/usecases/create_account.dart';
import 'package:perfin_app/features/auth/domain/usecases/get_current_user.dart';
import 'package:perfin_app/features/auth/domain/usecases/is_logged_in.dart';
import 'package:perfin_app/features/auth/domain/usecases/login.dart';
import 'package:perfin_app/features/auth/presentation/cubit/login_cubit.dart';
import 'package:perfin_app/features/auth/presentation/cubit/register_cubit.dart';

GetIt getIt = GetIt.instance;

// setup the dependency injection
// since we don't use build_runner to generate the
// service locator, so we defined our classes manually

void setupLocator() {
  // datasources
  getIt.registerLazySingleton<AuthDataSource>(() => AuthDataSourceImpl());

  //repositories
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());

  // usecases
  // auth
  getIt.registerLazySingleton<CreateAccount>(() => CreateAccount());
  getIt.registerLazySingleton<GetCurrentUser>(() => GetCurrentUser());
  getIt.registerLazySingleton<IsLoggedIn>(() => IsLoggedIn());
  getIt.registerLazySingleton<Login>(() => Login());

  // cubits
  // auth
  getIt.registerLazySingleton<RegisterCubit>(() => RegisterCubit());
  getIt.registerLazySingleton<LoginCubit>(() => LoginCubit());
}
