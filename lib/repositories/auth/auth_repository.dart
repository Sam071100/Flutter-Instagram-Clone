import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/services.dart';
import 'package:instagram_clone/repositories/repositories.dart';
import 'package:meta/meta.dart';

class AuthRepository extends BaseAuthRepository {
  final FirebaseFirestore _firebaseFirestore;
  final auth.FirebaseAuth _firebaseAuth;

  AuthRepository({
    FirebaseFirestore firebaseFirestore,
    auth.FirebaseAuth firebaseAuth,
  })  : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance,
        _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance;
  @override
  // TODO: implement user
  Stream<auth.User> get user => _firebaseAuth.userChanges();

  @override
  Future<auth.User> signupWithEmailAndPassword({
    @required String username,
    @required String email,
    @required String password,
  }) async {
    // TODO: implement signupWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<auth.User> logInWithEmailAndPassword({
    @required String email,
    @required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password,)
    } on auth.FirebaseAuthException catch (err) {}
    on PlatformException catch (err) {}
  }

  @override
  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }
}
