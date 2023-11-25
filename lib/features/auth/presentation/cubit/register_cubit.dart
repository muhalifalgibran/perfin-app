import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfin_app/core/di/service_locator.dart';
import 'package:perfin_app/core/error/failure.dart';
import 'package:perfin_app/features/auth/domain/usecases/create_account.dart';

enum RegisterStatus {
  initial,
  success,
  loading,
  failure,
}

class RegisterState extends Equatable {
  final RegisterStatus status;
  final Failure? failure;

  bool get isLoading => status == RegisterStatus.loading;
  bool get isSuccess => status == RegisterStatus.success;
  bool get isFailed => status == RegisterStatus.failure;
  bool get isInitial => status == RegisterStatus.initial;

  const RegisterState({
    this.status = RegisterStatus.initial,
    this.failure,
  });

  RegisterState copyWith({
    RegisterStatus? status,
    Failure? failure,
  }) =>
      RegisterState(
        status: status ?? this.status,
        failure: failure ?? this.failure,
      );

  @override
  List<Object?> get props => [status, failure];
}

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(const RegisterState());

  void register(String email, String password) async {
    emit(state.copyWith(status: RegisterStatus.loading));

    final usecase = await getIt<CreateAccount>().call(email, password);
    // give delay since the execution is very fast for better ux
    usecase.fold(
      (error) => emit(
        state.copyWith(status: RegisterStatus.failure, failure: error),
      ),
      (r) => emit(
        state.copyWith(status: RegisterStatus.success),
      ),
    );
  }
}
