import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfin_app/core/di/service_locator.dart';
import 'package:perfin_app/core/error/failure.dart';
import 'package:perfin_app/features/auth/domain/usecases/is_logged_in.dart';
import 'package:perfin_app/features/auth/domain/usecases/login.dart';

enum LoginStatus {
  initial,
  success,
  loading,
  failure,
  isLoggedIn,
  isNotLoggedIn,
}

class LoginState extends Equatable {
  final LoginStatus status;
  final Failure? failure;

  bool get isLoading => status == LoginStatus.loading;
  bool get isSuccess => status == LoginStatus.success;
  bool get isLoggedIn => status == LoginStatus.isLoggedIn;
  bool get isNotLoggedIn => status == LoginStatus.isNotLoggedIn;
  bool get isFailed => status == LoginStatus.failure;
  bool get isInitial => status == LoginStatus.initial;

  const LoginState({
    this.status = LoginStatus.initial,
    this.failure,
  });

  LoginState copyWith({
    LoginStatus? status,
    Failure? failure,
  }) =>
      LoginState(
        status: status ?? this.status,
        failure: failure ?? this.failure,
      );

  @override
  List<Object?> get props => [
        status,
        failure,
      ];
}

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  void doLogin(String email, String password) async {
    emit(state.copyWith(status: LoginStatus.loading));

    final usecase = await getIt<Login>().call(email, password);
    await Future.delayed(const Duration(milliseconds: 750));

    usecase.fold(
      (error) => emit(
        state.copyWith(status: LoginStatus.failure, failure: error),
      ),
      (r) => emit(
        state.copyWith(status: LoginStatus.success),
      ),
    );
  }

  void checkLoggedIn() async {
    emit(state.copyWith(status: LoginStatus.loading));

    final usecase = await getIt<IsLoggedIn>().call(NoParams());

    await Future.delayed(const Duration(milliseconds: 750));

    usecase.fold(
      (error) => emit(
        state.copyWith(status: LoginStatus.failure, failure: error),
      ),
      (data) => data
          ? emit(state.copyWith(status: LoginStatus.isLoggedIn))
          : emit(state.copyWith(status: LoginStatus.isNotLoggedIn)),
    );
  }
}
