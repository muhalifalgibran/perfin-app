import 'package:firebase_auth/firebase_auth.dart';
import 'package:perfin_app/core/firebase/firebase_auth_client.dart';

abstract class AuthDataSource {
  Future<void> createAccount(String email, String password);
  Future<void> login(String email, String password);
  Future<bool> isLoggedIn();
  Future<User?> getCurrentUser();
}

// we should not catch the error here since we treat our repository
// as DTO so our repository should return whether an error or the expected object
// here if there is an error we just need to throw it and should be catched in repository
class AuthDataSourceImpl implements AuthDataSource {
  final _firebaseAuthClient = FirebaseAuthClient();

  @override
  Future<void> createAccount(String email, String password) async {
    await _firebaseAuthClient.createUser(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> login(String email, String password) async {
    await _firebaseAuthClient.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<bool> isLoggedIn() async {
    return _firebaseAuthClient.currentUser != null;
  }

  @override
  Future<User?> getCurrentUser() async {
    return _firebaseAuthClient.currentUser;
  }
}
