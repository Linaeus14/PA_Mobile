part of './service.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Map<String, dynamic>> regis(String email, String password) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Extract the user ID from the userCredential
      String userId = userCredential.user?.uid ?? '';

      // Return a map with 'success' and 'userId' keys
      return {'success': true, 'userId': userId};
    } catch (e) {
      // Return a map with 'success' key set to false
      return {'success': false};
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      final userId = user?.uid;

      debugPrint("Login Success");
      return {'success': true, 'userId': userId};
    } catch (e) {
      debugPrint("Login Failed");
      return {'success': false, 'userId': null};
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
