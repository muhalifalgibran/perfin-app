import 'package:equatable/equatable.dart';

class Money extends Equatable {
  final String userId;
  final num totalMoney;
  final bool isRising;
  final num money;

  const Money({
    required this.userId,
    required this.totalMoney,
    required this.isRising,
    required this.money,
  });

  Money copyWith({
    String? userId,
    num? totalMoney,
    bool? isRising,
    num? money,
  }) =>
      Money(
        userId: userId ?? this.userId,
        totalMoney: totalMoney ?? this.totalMoney,
        isRising: isRising ?? this.isRising,
        money: money ?? this.money,
      );

  @override
  List<Object?> get props => [
        userId,
        totalMoney,
        isRising,
        money,
      ];
}
