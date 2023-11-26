import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfin_app/core/di/service_locator.dart';
import 'package:perfin_app/core/error/failure.dart';
import 'package:perfin_app/features/auth/domain/usecases/get_current_user.dart';
import 'package:perfin_app/features/home/domain/entities/money.dart';
import 'package:perfin_app/features/home/domain/entities/user_x.dart';
import 'package:perfin_app/features/home/domain/usecases/get_user_firestore.dart';
import 'package:perfin_app/features/home/domain/usecases/get_user_money.dart';

enum HomeStatus {
  initial,
  loading,
  success,
  failure,
}

class HomeState extends Equatable {
  final HomeStatus status;
  final Failure? failure;
  final UserX? userData;
  final List<Money>? userMoney;

  const HomeState({
    this.status = HomeStatus.initial,
    this.failure,
    this.userData,
    this.userMoney,
  });

  bool get isLoading => status == HomeStatus.loading;
  bool get isSuccess => status == HomeStatus.success;
  bool get isFailed => status == HomeStatus.failure;
  bool get isInitial => status == HomeStatus.initial;

  HomeState copyWith({
    HomeStatus? status,
    Failure? failure,
    UserX? userData,
    List<Money>? userMoney,
  }) =>
      HomeState(
        status: status ?? this.status,
        failure: failure ?? this.failure,
        userData: userData ?? this.userData,
        userMoney: userMoney ?? this.userMoney,
      );

  @override
  List<Object?> get props => [
        status,
        failure,
        userData,
        userMoney,
      ];
}

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  void getUserData() async {
    emit(state.copyWith(status: HomeStatus.loading));

    // get user id
    final user = await getIt<GetCurrentUser>().call(NoParams());
    String userId = '';
    user.fold(
        (failure) => emit(
              state.copyWith(status: HomeStatus.failure, failure: failure),
            ),
        (data) => userId = data?.uid ?? '');

    // get current user firestore
    final userFirestore = await getIt<GetUserFirestore>().call(userId);
    userFirestore.fold(
      (failure) => emit(
        state.copyWith(status: HomeStatus.failure, failure: failure),
      ),
      (data) => emit(state.copyWith(userData: data)),
    );

    // get user money
    final userMoney = await getIt<GetUserMoney>().call(userId);

    userMoney.fold(
      (failure) => emit(
        state.copyWith(status: HomeStatus.failure, failure: failure),
      ),
      (data) =>
          emit(state.copyWith(userMoney: data, status: HomeStatus.success)),
    );
  }
}
