import 'package:perfin_app/features/home/domain/entities/money.dart';

class MoneyModel extends Money {
  const MoneyModel({
    required super.userId,
    required super.totalMoney,
    required super.isRising,
    required super.money,
  });

  factory MoneyModel.fromJson(Map<String, dynamic> json) => MoneyModel(
        userId: json['userId'],
        totalMoney: json['totalMoney'],
        isRising: json['isRising'],
        money: json['money'],
      );

  Map<String, dynamic> toJson(Money money) {
    return {
      'userId': money.userId,
      'totalMoney': money.totalMoney,
      'isRising': money.isRising,
      'money': money.money,
    };
  }
}
