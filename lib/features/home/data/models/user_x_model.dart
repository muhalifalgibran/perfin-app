import 'package:perfin_app/features/home/domain/entities/user_x.dart';

class UserXModel extends UserX {
  const UserXModel({
    required super.email,
    required super.userId,
    required super.totalMoney,
  });

  factory UserXModel.fromJson(Map<String, dynamic> json) => UserXModel(
        email: json['email'],
        userId: json['id'],
        totalMoney: json['totalMoney'],
      );

  Map<String, dynamic> toJson(UserX user) {
    return {
      'email': user.email,
      'userId': user.userId,
      'totalMoney': user.totalMoney,
    };
  }
}
