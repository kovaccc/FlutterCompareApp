import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:fluttercompareapp/common/domain/either_failure_or.dart';
import 'package:loggy/loggy.dart';

import 'package:fluttercompareapp/common/domain/entities/failure.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl();
});

abstract class AuthRepository {
  EitherFailureOr<UserCredential> register(String email, String password);

  EitherFailureOr<UserCredential> signIn(String email, String password);

  EitherFailureOr<None> signOut(String email, String password);

  Stream<User?> getFirebaseUserStream();
}

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl();

  @override
  EitherFailureOr<UserCredential> register(
    String email,
    String password,
  ) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(credential);
    } on FirebaseAuthException catch (error, stackTrace) {
      if (error.code == 'weak-password') {
        logError('The password provided is too weak.');
      } else if (error.code == 'email-already-in-use') {
        logError('The account already exists for that email.');
      }
      return Left(
        Failure.generic(error: error, stackTrace: stackTrace),
      );
    } catch (error, stackTrace) {
      return Left(
        Failure.generic(error: error, stackTrace: stackTrace),
      );
    }
  }

  @override
  EitherFailureOr<UserCredential> signIn(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(credential);
    } on FirebaseAuthException catch (error, stackTrace) {
      if (error.code == 'user-not-found') {
        logError('No user found for that email.');
      } else if (error.code == 'wrong-password') {
        logError('Wrong password provided for that user.');
      }
      return Left(
        Failure.generic(error: error, stackTrace: stackTrace),
      );
    } catch (error, stackTrace) {
      return Left(
        Failure.generic(error: error, stackTrace: stackTrace),
      );
    }
  }

  @override
  EitherFailureOr<None> signOut(String email, String password) async {
    try {
      await FirebaseAuth.instance.signOut();
      return const Right(None());
    } on FirebaseAuthException catch (error, stackTrace) {
      return Left(
        Failure.generic(error: error, stackTrace: stackTrace),
      );
    } catch (error, stackTrace) {
      return Left(
        Failure.generic(error: error, stackTrace: stackTrace),
      );
    }
  }

  @override
  Stream<User?> getFirebaseUserStream() {
    return FirebaseAuth.instance.authStateChanges().asBroadcastStream();
  }
}
