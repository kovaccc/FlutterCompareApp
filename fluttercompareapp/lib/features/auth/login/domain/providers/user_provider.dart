import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userProvider = Provider<User?>((ref) {
  return FirebaseAuth.instance.currentUser;
});
