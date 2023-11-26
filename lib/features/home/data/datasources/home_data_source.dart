import 'package:perfin_app/core/firebase/firebase_auth_client.dart';
import 'package:perfin_app/core/firebase/firebase_firestore_client.dart';
import 'package:perfin_app/features/home/data/models/money_model.dart';
import 'package:perfin_app/features/home/data/models/user_x_model.dart';
import 'package:perfin_app/features/home/domain/entities/money.dart';

import '../../domain/entities/user_x.dart';

abstract class HomeDataSource {
  Future<UserX> getCurrentUser(String userId);
  Future<List<Money>?> getCurrentUserMoney(String userId);
  Future<void> logout();
}

class HomeDataSourceImpl implements HomeDataSource {
  final _client = FirebaseFirestoreClient();
  final _clientAuth = FirebaseAuthClient();

  @override
  Future<UserX> getCurrentUser(String userId) async {
    final result = await _client.getListData('users', userId);
    return UserXModel.fromJson(result.first.data());
  }

  @override
  Future<List<Money>?> getCurrentUserMoney(String userId) async {
    final result = await _client.getListData('money', userId);

    return result.map((e) => MoneyModel.fromJson(e.data())).toList();
  }

  @override
  Future<void> logout() async {
    await _clientAuth.signOut();
  }
}
