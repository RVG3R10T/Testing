import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/user.dart' as user_model;

final authServiceProvider = Provider((ref) => AuthService());

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /// Get current user
  User? get currentUser => _firebaseAuth.currentUser;

  /// Get current user ID token
  Future<String?> getIdToken() async {
    return await currentUser?.getIdToken();
  }

  /// Register with email and password
  Future<User?> registerWithEmail({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCredential.user?.updateDisplayName('$firstName $lastName');

      return userCredential.user;
    } catch (e) {
      print('Registration error: $e');
      rethrow;
    }
  }

  /// Login with email and password
  Future<User?> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print('Login error: $e');
      rethrow;
    }
  }

  /// Logout
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  /// Check if user is authenticated
  bool get isAuthenticated => _firebaseAuth.currentUser != null;

  /// Get auth state stream
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
}
