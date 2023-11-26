import 'package:perfin_app/core/firebase/firebase_firestore_client.dart';
import 'package:perfin_app/features/home/data/models/money_model.dart';
import 'package:perfin_app/features/home/domain/entities/money.dart';

abstract class MoneyDataSource {
  Future<void> changeMoney(Money money, num newTotal);
}

class MoneyDataSourceImpl implements MoneyDataSource {
  final _client = FirebaseFirestoreClient();
  @override
  Future<void> changeMoney(Money money, num newTotal) async {
    // add log money
    await _client.setData(
      collection: 'money',
      data: MoneyModel.toJson(money),
    );

    final docId = await _client.getDocumentId('users', money.userId);

    // change user money
    await _client.updateData(
      collection: 'users',
      data: {'totalMoney': newTotal},
      documentId: docId,
    );
  }
}
