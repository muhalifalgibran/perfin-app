import 'package:equatable/equatable.dart';

class Money extends Equatable {
  final String userId;
  final int totalMoney;
  final bool isRising;
  final int money;

  const Money({
    required this.userId,
    required this.totalMoney,
    required this.isRising,
    required this.money,
  });

  @override
  List<Object?> get props => [
        userId,
        totalMoney,
        isRising,
        money,
      ];
}
