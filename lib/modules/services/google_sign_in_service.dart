import 'package:firebase_auth/firebase_auth.dart';
import 'package:friend_animals/modules/models/user_model.dart';
import 'package:friend_animals/modules/services/service.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'error_writer.dart';

class GoogleSignInService {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<UserModel?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser != null) {
        // Obtain the auth details from the request
        final googleAuth = await googleUser.authentication;
        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        //Create a new User Model
        final UserModel userModel = UserModel(
          displayName: googleUser.displayName!,
          email: googleUser.email,
          id: googleUser.id,
          photoUrl: googleUser.photoUrl!,
          loginDate: DateTime.now().toString(),
        );

        // Once signed in, return the UserCredential
        await _firebaseAuth.signInWithCredential(credential);

        return userModel;
      }
      return null;
    } on FirebaseException catch (e) {
      ErrorWriter.write(e, this);
    }
    return null;
  }

  Future<void> sigOutGoogle() async {
    await GoogleSignIn().signOut();
  }
}
