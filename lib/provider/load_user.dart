import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sohna_salon_app/models/load_user_class.dart';

// final userProvider = StreamProvider<LoadUserClass>((ref) {
//   final userId = FirebaseAuth.instance.currentUser?.uid;
//   if (userId == null) {
//     throw Exception("User not logged in");
//   }

//   return FirebaseFirestore.instance
//       .collection('SignUp Users')
//       .doc(userId)
//       .snapshots()
//       .map((snapshot) {
//     final data = snapshot.data()!;
//     return LoadUserClass(
//       name: data['name'],
//       photoUrl: data['photoUrl'],
//       email: data['email'],
//     );
//   });
// });

final userProvider = StreamProvider<LoadUserClass>((ref) {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    throw Exception("User not logged in");
  }

  // Check if the user signed in with Google
  final isGoogleSignIn = user.providerData
      .any((userInfo) => userInfo.providerId == GoogleAuthProvider.PROVIDER_ID);

  if (isGoogleSignIn) {
    // Fetch data from "Google Users" collection for Google sign-ins
    return FirebaseFirestore.instance
        .collection('Google Users')
        .doc(user.uid)
        .snapshots()
        .map((snapshot) {
      final data = snapshot.data()!;
      return LoadUserClass(
        name: data['name'],
        photoUrl: data['photoUrl'],
        email: data['email'],
      );
    });
  } else {
    // Fetch data from "SignUp Users" collection for email/password sign-ins
    return FirebaseFirestore.instance
        .collection('SignUp Users')
        .doc(user.uid)
        .snapshots()
        .map((snapshot) {
      final data = snapshot.data()!;
      return LoadUserClass(
        name: data['name'],
        photoUrl: data['photoUrl'],
        email: data['email'],
      );
    });
  }
});
