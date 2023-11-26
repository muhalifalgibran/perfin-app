import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfin_app/core/di/service_locator.dart';
import 'package:perfin_app/core/error/failure.dart';
import 'package:perfin_app/features/home/domain/entities/money.dart';
import 'package:perfin_app/features/home/domain/usecases/change_money.dart';

enum MoneyStatus {
  initial,
  loading,
  success,
  failure,
}

class MoneyState extends Equatable {
  final MoneyStatus status;
  final Failure? failure;

  const MoneyState({
    this.status = MoneyStatus.initial,
    this.failure,
  });

  bool get isLoading => status == MoneyStatus.loading;
  bool get isSuccess => status == MoneyStatus.success;
  bool get isFailed => status == MoneyStatus.failure;
  bool get isInitial => status == MoneyStatus.initial;

  MoneyState copyWith({
    MoneyStatus? status,
    Failure? failure,
  }) =>
      MoneyState(
        status: status ?? this.status,
        failure: failure ?? this.failure,
      );

  @override
  List<Object?> get props => [status, failure];
}

class MoneyCubit extends Cubit<MoneyState> {
  MoneyCubit() : super(const MoneyState());

  void changeMoney(Money money, num newTotal) async {
    emit(state.copyWith(status: MoneyStatus.loading));

    final result = await getIt<ChangeMoney>().call(money, newTotal);

    result.fold(
      (failure) => emit(
        state.copyWith(status: MoneyStatus.failure, failure: failure),
      ),
      (data) => emit(state.copyWith(status: MoneyStatus.success)),
    );
  }
}
