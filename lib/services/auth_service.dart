import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // Current user
  static User? get currentUser => _auth.currentUser;

  // Authentication changes stream
  static Stream<User?> get authStateChanges =>
      _auth.authStateChanges();

  // Sign up with email and password
  static Future<UserCredential> signUp(
    String email,
    String password,
  ) async {
    return await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Login with email and password
  static Future<UserCredential> login(
    String email,
    String password,
  ) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Google Sign-In
  static Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn().signIn();

    if (googleUser == null) {
      throw Exception("Google sign in cancelled");
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential =
        GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await _auth.signInWithCredential(
      credential,
    );
  }

  // Logout
  static Future<void> logout() async {
    await GoogleSignIn().signOut();
    await _auth.signOut();
  }
}