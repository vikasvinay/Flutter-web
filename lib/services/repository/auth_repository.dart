import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      print('Successfully logged in, User UID: ${user.uid}');
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<Map<dynamic, dynamic>> get _userAcces async {
    final user = _auth.currentUser;
    final idTokenResult = await user.getIdTokenResult(true);

    return idTokenResult.claims;
  }
}
