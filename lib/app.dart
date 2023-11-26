import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfin_app/core/di/service_locator.dart';
import 'package:perfin_app/features/auth/presentation/cubit/login_cubit.dart';
import 'package:perfin_app/features/auth/presentation/cubit/register_cubit.dart';
import 'package:perfin_app/features/auth/presentation/pages/login_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      bloc: getIt<LoginCubit>()..checkLoggedIn(),
      listener: (BuildContext context, state) {
        if (state.isLoggedIn) {
          // TODO: Go to dashboard
        } else if (state.isNotLoggedIn) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ),
          );
        }
      },
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'PerFin.',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.normal,
              ),
            ),
            Text(
              'Your simple personal finance management app',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
