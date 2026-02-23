import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // INSCRIPTION COMPLETE
  Future<User?> registerUser({
    required String email,
    required String password,
    required String nom,
    required String prenom,
    required String role,
    required String hopital,
    required String telephone,
  }) async {
    UserCredential result =
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    User? user = result.user;

    if (user != null) {
      await _db.collection('users').doc(user.uid).set({
        'nom': nom,
        'prenom': prenom,
        'email': email,
        'role': role,
        'hopital': hopital,
        'telephone': telephone,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
    return user;
  }

  // CONNEXION
  Future<User?> login(String email, String password) async {
    UserCredential result =
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result.user;
  }

  // LOGOUT
  Future<void> logout() async {
    await _auth.signOut();
  }

}
