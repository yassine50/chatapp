import 'dart:convert';
import 'dart:math';

import 'package:chatapp/model/Account.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'Tools.dart';
import 'fb_rdb.dart';

class FB_Auth {
  static String error = '';

  Future<int> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
   //   userCredential.user!.sendEmailVerification();
   return 1 ; 

      // if (userCredential.user!.emailVerified) {
      //   return 1;
      // } else {
      //   userCredential.user!.sendEmailVerification();
      //   return -10;
      // }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return -11;
      } else if (e.code == 'wrong-password') {
        return -12;
      }
    }on Error catch (error) {
      FB_RBD fb = FB_RBD() ;
      fb.Update_Data("/logFile/"+Tools.Cast_email(Account().accountID)+"/"+Tools.Cast_email(Account().accountID)+"/"+Tools().timestampRelative.toString(), {
        "sgin_in":"sgin in",
        "log" : error.toString()
      });
      print(error);
      throw Exception('An error occurred during the database operation');
    }
    return -1;
  }
  Future<bool> signUp(String email, String password) async {
    bool verif = true;
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        error = 'weak-password';
         print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        error = 'email-already-in-use';
         print('The account already exists for that email.');
      } else if (e.code == 'invalid-email') {
        error = 'invalid-email';
        print('invalid-email');
      }else {
        print(e.code) ;
      }
      verif = false;
    } on Error catch (error) {
      FB_RBD fb = FB_RBD() ;
      fb.Update_Data("/logFile/"+ Tools.Cast_email(Account().accountID)+"/"+Tools.Cast_email(Account().accountID)+"/"+Tools().timestampRelative.toString(), {
        "sgin_in":"signUp",
        "log" : error.toString()
      });
      print(error);
      throw Exception('An error occurred during the database operation');
      verif = false;
    }
    return verif;
  }

  Future ResetPassword(String email) async {
    bool verif = true;
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        error = 'user-not-found';
      }
      // print(e.code);
      verif = false;
    }on Error catch (error) {
      FB_RBD fb = FB_RBD() ;
      fb.Update_Data("/logFile/"+Tools.Cast_email(Account().accountID)+"/"+Tools.Cast_email(Account().accountID)+"/"+Tools().timestampRelative.toString(), {
        "log" : error.toString()
      });
      print(error);
      throw Exception('An error occurred during the database operation');
      verif = false;
    }
    return verif;
  }

  // Future Email_verif(String email) async {
  //   var acs = ActionCodeSettings(
  //       // URL you want to redirect back to. The domain (www.example.com) for this
  //       // URL must be whitelisted in the Firebase Console.
  //       url: Constants.url_email_verif,
  //       // This must be true
  //       handleCodeInApp: true,
  //       iOSBundleId: Constants.iOSBundleId,
  //       androidPackageName: Constants.androidPackageName,
  //       // installIfNotAvailable
  //       androidInstallApp: true,
  //       // minimumVersion
  //       androidMinimumVersion: Constants.androidMinimumVersion);

  //   var emailAuth = email;
  //   FirebaseAuth.instance
  //       .sendSignInLinkToEmail(email: emailAuth, actionCodeSettings: acs)
  //       .catchError(
  //           (onError) => print('Error sending email verification $onError'))
  //       .then((value) => print('Successfully sent email verification'));
  // }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  Future Change_password(String password) async {
    bool verif = true;
    User? user = await FirebaseAuth.instance.currentUser;
    user?.updatePassword(password).then((_) {
      print("Successfully changed password");
    }).catchError((error) {
      verif = false;
      print("Password can't be changed" + error.toString());
      //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
    });
    return verif;
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }on Error catch (error) {
      FB_RBD fb = FB_RBD() ;
      fb.Update_Data("/logFile/"+Tools.Cast_email(Account().accountID)+"/"+Tools.Cast_email(Account().accountID)+"/"+Tools().timestampRelative.toString(), {
        "log" : error.toString()
      });
      print(error);
      throw Exception('An error occurred during the database operation');
    }

  }

  // sgin in with apple  ..........................................................................................

  String generateNonce([int length = 32]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<UserCredential> signInWithApple() async {
    try {
      // To prevent replay attacks with the credential returned from Apple, we
      // include a nonce in the credential request. When signing in with
      // Firebase, the nonce in the id token returned by Apple, is expected to
      // match the sha256 hash of `rawNonce`.
      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);

      // Request credential for the currently signed in Apple account.
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      // Create an `OAuthCredential` from the credential returned by Apple.
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      // Sign in the user with Firebase. If the nonce we generated earlier does
      // not match the nonce in `appleCredential.identityToken`, sign in will fail.
      return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
    }on Error catch (error) {
      FB_RBD fb = FB_RBD() ;
      fb.Update_Data("/logFile/"+Tools.Cast_email(Account().accountID)+"/"+Tools.Cast_email(Account().accountID)+"/"+Tools().timestampRelative.toString(), {
        "log" : error.toString()
      });
      print(error);
      throw Exception('An error occurred during the database operation');
    }
  }
}
