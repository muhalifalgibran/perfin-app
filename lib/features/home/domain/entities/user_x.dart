import 'package:equatable/equatable.dart';

class UserX extends Equatable {
  final String email;
  final String userId;
  final int totalMoney;

  const UserX({
    required this.email,
    required this.userId,
    required this.totalMoney,
  });

  @override
  List<Object?> get props => [email, userId, totalMoney];
}
