import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFirestoreClient {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  void setData({
    required String collection,
    required Map<String, dynamic> data,
  }) async {
    await _firebaseFirestore.collection(collection).add(data);
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getListData(
      String collection, String userId) async {
    return await _firebaseFirestore
        .collection(collection)
        .where('userId', isEqualTo: userId)
        .get()
        .then(
          (value) async => value.docs,
        );
  }
}
