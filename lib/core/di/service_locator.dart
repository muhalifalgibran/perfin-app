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
import 'package:perfin_app/features/home/data/datasources/home_data_source.dart';
import 'package:perfin_app/features/home/data/datasources/money_data_source.dart';
import 'package:perfin_app/features/home/data/repositories/home_repository_impl.dart';
import 'package:perfin_app/features/home/data/repositories/money_repository_impl.dart';
import 'package:perfin_app/features/home/domain/repositories/home_repository.dart';
import 'package:perfin_app/features/home/domain/repositories/money_repository.dart';
import 'package:perfin_app/features/home/domain/usecases/change_money.dart';
import 'package:perfin_app/features/home/domain/usecases/get_user_firestore.dart';
import 'package:perfin_app/features/home/domain/usecases/get_user_money.dart';
import 'package:perfin_app/features/home/presentation/cubits/home_cubit.dart';
import 'package:perfin_app/features/home/presentation/cubits/money_cubit.dart';

GetIt getIt = GetIt.instance;

// setup the dependency injection
// since we don't use build_runner to generate the
// service locator, so we defined our classes manually

void setupLocator() {
  // datasources
  getIt.registerLazySingleton<AuthDataSource>(() => AuthDataSourceImpl());
  getIt.registerLazySingleton<HomeDataSource>(() => HomeDataSourceImpl());
  getIt.registerLazySingleton<MoneyDataSource>(() => MoneyDataSourceImpl());

  //repositories
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());
  getIt.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl());
  getIt.registerLazySingleton<MoneyRepository>(() => MoneyRepositoryImpl());

  // usecases
  // auth
  getIt.registerLazySingleton<CreateAccount>(() => CreateAccount());
  getIt.registerLazySingleton<GetCurrentUser>(() => GetCurrentUser());
  getIt.registerLazySingleton<IsLoggedIn>(() => IsLoggedIn());
  getIt.registerLazySingleton<Login>(() => Login());

  // home
  getIt.registerLazySingleton<GetUserFirestore>(() => GetUserFirestore());
  getIt.registerLazySingleton<GetUserMoney>(() => GetUserMoney());
  getIt.registerLazySingleton<ChangeMoney>(() => ChangeMoney());

  // cubits
  // auth
  getIt.registerLazySingleton<RegisterCubit>(() => RegisterCubit());
  getIt.registerLazySingleton<LoginCubit>(() => LoginCubit());

  // home
  getIt.registerLazySingleton<HomeCubit>(() => HomeCubit());
  getIt.registerLazySingleton<MoneyCubit>(() => MoneyCubit());
}
