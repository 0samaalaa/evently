import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthManager {
  static Future<UserCredential?> createAccount(
      {required String mail,
      required String password,
      required String name}) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: mail,
        password: password,
      );
      if (credential.user != null) {
        await credential.user!.updateProfile(displayName: name);
      }
      return credential;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<UserCredential?> login({
    required String mail,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: mail,
        password: password,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<void> resetPassword({
    required String mail,
  }) async {
    try {
       await FirebaseAuth.instance.sendPasswordResetEmail(
        email: mail,
      );
    }  catch (e) {
      print(e);
    }
  }
}
