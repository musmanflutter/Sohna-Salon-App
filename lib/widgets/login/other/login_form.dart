import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sohna_salon_app/widgets/login/buttons/forgot_password.dart';
import 'package:sohna_salon_app/widgets/login/buttons/google_signin_button.dart';
import 'package:sohna_salon_app/widgets/login/buttons/normal_signin_button.dart';

import 'package:sohna_salon_app/widgets/login/fields/email.dart';
import 'package:sohna_salon_app/widgets/login/fields/password.dart';
import 'package:sohna_salon_app/widgets/login/fields/user_name.dart';

import 'package:sohna_salon_app/widgets/login/other/last_line.dart';
import 'package:sohna_salon_app/widgets/login/other/or_divider.dart';

final _fireBase = FirebaseAuth.instance;

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _form = GlobalKey<FormState>();
  var _isLogin = true;
  var _enteredName = '';
  var _enteredEmail = '';
  var _enteredPassword = '';
  var _isAuthenticating = false;
  var _isAuthenticatingForGoogleFb = false;

  _signInWithGooglee() async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      setState(() {
        _isAuthenticatingForGoogleFb = true;
      });

      // Start a timer to reset _isAuthenticatingForGoogleFb after 3 seconds
      Timer(const Duration(seconds: 3), () {
        setState(() {
          _isAuthenticatingForGoogleFb = false;
        });
      });

      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      if (gUser != null) {
        final GoogleSignInAuthentication gAuth = await gUser.authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken,
          idToken: gAuth.idToken,
        );
        await _fireBase.signInWithCredential(credential);
      }
      final user = _fireBase.currentUser;
      final userEmail = user?.email;
      final userName = user?.displayName;

      await FirebaseFirestore.instance
          .collection('Google Users')
          .doc(user!.uid)
          .set({
        'email': userEmail,
        'name': userName,
        'photoUrl': user.photoURL,
      });
    } on FirebaseAuthException catch (error) {
      messenger.clearSnackBars();
      messenger.showSnackBar(
        SnackBar(
          content: Text(error.message ?? 'Authentication failed'),
        ),
      );
    }
  }

  void _submit() async {
    final isValid = _form.currentState!.validate();
    final messenger = ScaffoldMessenger.of(context);

    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    try {
      setState(() {
        _isAuthenticating = true;
      });
      if (_isLogin) {
        await _fireBase.signInWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);
        final userId = FirebaseAuth.instance.currentUser?.uid;
        final userData = await FirebaseFirestore.instance
            .collection('SignUp Users')
            .doc(userId)
            .get();
        final fetchedName = userData.data()?['name'];

        // Store fetched name in SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('name', fetchedName);
        // print('Fetched and stored name: $fetchedName');
      } else {
        final userCredentials = await _fireBase.createUserWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);
        await FirebaseFirestore.instance
            .collection('SignUp Users')
            .doc(userCredentials.user!.uid)
            .set({
          'email': _enteredEmail,
          'name': _enteredName,
        });
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('name', _enteredName);
      }
    } on FirebaseAuthException catch (error) {
      messenger.clearSnackBars();
      messenger.showSnackBar(
        SnackBar(
          content: Text(error.message ?? 'Authentication failed'),
        ),
      );

      setState(() {
        _isAuthenticating = false;
      });
    }
  }

  void toggleIsLogin(bool newValue) {
    setState(() {
      _isLogin = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaObject = MediaQuery.of(context);
    final screenSize = mediaObject.size;
    final firstHeight = (screenSize.height - mediaObject.padding.top) * 0.575;
    final secondHeight = (screenSize.height - mediaObject.padding.top) * 0.625;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: _isLogin ? firstHeight : secondHeight,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 4,
        margin: EdgeInsets.symmetric(
          horizontal: screenSize.width * 0.04,
          vertical: (screenSize.height - mediaObject.padding.top) * 0.02,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenSize.width * 0.05,
            vertical: (screenSize.height - mediaObject.padding.top) * 0.02,
          ),
          child: Form(
            key: _form,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (!_isLogin)
                    UserName(
                      onNameChange: (value) {
                        setState(() {
                          _enteredName = value;
                        });
                      },
                    ),
                  Email(
                    onNameChange: (value) {
                      setState(() {
                        _enteredEmail = value;
                      });
                    },
                  ),
                  Password(
                    onNameChange: (value) {
                      setState(() {
                        _enteredPassword = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: screenSize.height * 0.005,
                  ),
                  if (_isLogin) const ForgotPassword(),
                  SizedBox(
                    height: screenSize.height * 0.02,
                  ),
                  _isAuthenticating
                      ? const CircularProgressIndicator()
                      : NormalSignInButton(
                          isAuthenticatingForGoogleFb:
                              _isAuthenticatingForGoogleFb,
                          isLogin: _isLogin,
                          onPressed: _submit),
                  SizedBox(
                    height: screenSize.height * 0.01,
                  ),
                  const OrDivider(),
                  SizedBox(
                    height: screenSize.height * 0.01,
                  ),
                  _isAuthenticatingForGoogleFb
                      ? const CircularProgressIndicator()
                      : GoogleSignInButton(onPressed: _signInWithGooglee),
                  SizedBox(
                    height: screenSize.height * 0.02,
                  ),
                  LastLine(isLogin: _isLogin, onTap: toggleIsLogin),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
