import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfin_app/core/error/failure.dart';
import 'package:perfin_app/features/home/domain/entities/money.dart';

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

  void changeMoney(Money money) {}
}
