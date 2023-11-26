import 'package:equatable/equatable.dart';

class UserX extends Equatable {
  final String email;
  final String id;
  final int totalMoney;

  const UserX({
    required this.email,
    required this.id,
    required this.totalMoney,
  });

  @override
  List<Object?> get props => [email, id, totalMoney];
}
