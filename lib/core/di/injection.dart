import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfin_app/core/di/service_locator.dart';
import 'package:perfin_app/features/auth/presentation/cubit/login_cubit.dart';
import 'package:perfin_app/features/auth/presentation/cubit/register_cubit.dart';

class Injection {
  Injection._privateConstructor();

  static final Injection _instance = Injection._privateConstructor();

  static Injection get instance => _instance;

  List<BlocProvider> initBloc() => [
        BlocProvider<RegisterCubit>(
          create: (context) => getIt<RegisterCubit>(),
        ),
        BlocProvider<LoginCubit>(
          create: (context) => getIt<LoginCubit>(),
        ),
      ];
}
