import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userRepositoryProvider = Provider((ref) {
  return UserRepository(FirebaseAuth.instance);
});

class UserRepository {
  final FirebaseAuth _firebaseAuth;

  UserRepository(this._firebaseAuth);

  Future createUser({required String username, required String email, required String password}) async {
    try {
      final response = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      response.user!.updateDisplayName(username);
      return response.user!;
    } on FirebaseAuthException catch (e) {
      return "${e.message}";
    }
  }

  User? getCurrentUser() {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      return user;
    }
    return null;
  }
  
  void updateUser() {
    final currentUser = getCurrentUser();

  }
  
  deleteUser() {
    
  }
}

