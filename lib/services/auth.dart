import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
class AuthService {
//we are using this stream to listen to any changes to the user
  final userStream = FirebaseAuth.instance.authStateChanges();  //sets userStream to a stream of the current user --stream
  final user = FirebaseAuth.instance.currentUser;  //if you want to check the user's state once this it -- future

/// ---------Anonymous Firebase login----------
  Future<void> anonLogin() async {  //all need to be async so u dont need to worry about it.  
    try {
      await FirebaseAuth.instance.signInAnonymously();
    } 
    on FirebaseAuthException {
      // handle error one day
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
/// ------Google Firebase Login----------      //johanes mike + etechviral source tutorial
  Future<void>googleLogin() async {
    try {
      final googleUser = await GoogleSignIn().signIn();   //google user just refers to sign in window will get user account

      if(googleUser == null) {
        return;  //if no user gets logged in then return.
      }
      final googleAuth = await googleUser.authentication;  //use for credential
      final authCredential = GoogleAuthProvider.credential(  //credential is created with access and Id token
        accessToken: googleAuth.accessToken,  //takes 
        idToken: googleAuth.idToken,
      );
    await FirebaseAuth.instance.signInWithCredential(authCredential);//passes access and id token to signinwith credentials method
    }
    on FirebaseAuthException {
      //handle error someday but not today....
    }
  }
  //this might be an L....
  //doesn't work as expected will try 
  getProfileImage() {
    var user = AuthService().user;
    if(user != null){
      return NetworkImage(user.photoURL!);
    }
    else{
      return Icon(Icons.abc, size: 100,);
    }
  }


/// --------------------Apple Firebase Login-----------------
/// this is currently an L.  
/// It requires the apple developer account which is 100 bucks so that shit is tough.
/// Planning on implementing this once the app is near completion.  
/// 
/// Not an L anymore code below
String generateNonce([int length = 32]) {
    const charset =
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
      accessToken: appleCredential.authorizationCode,//remove if apple bugs out
      rawNonce: rawNonce,
    );

    // Sign in the user with Firebase. If the nonce we generated earlier does
    // not match the nonce in `appleCredential.identityToken`, sign in will fail.
    return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
  }

}



