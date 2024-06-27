import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:sohna_salon_app/widgets/login/fields/email.dart';

final _fireBase = FirebaseAuth.instance;

class ForgotForm extends StatefulWidget {
  const ForgotForm({super.key});

  @override
  State<ForgotForm> createState() => _ForgotFormState();
}

class _ForgotFormState extends State<ForgotForm> {
  var _enteredEmail = '';
  var _isForget = false;
  final _form = GlobalKey<FormState>();

  Future forgotPassword() async {
    final isValid = _form.currentState!.validate();
    final messenger = ScaffoldMessenger.of(context);
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    try {
      setState(() {
        _isForget = true;
      });
      await _fireBase.sendPasswordResetEmail(email: _enteredEmail);
      messenger.clearSnackBars();
      messenger.showSnackBar(const SnackBar(
          content: Text('Password reset link sent! Check your email')));
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {}
      messenger.clearSnackBars();
      messenger.showSnackBar(
        SnackBar(
          content: Text(error.message ?? 'Authentication failed'),
        ),
      );
    }
    setState(() {
      _isForget = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 4,
      margin: EdgeInsets.all(screenSize.width * 0.04),
      child: Padding(
        padding: EdgeInsets.all(screenSize.width * 0.05),
        child: Form(
          key: _form,
          child: Column(
            children: [
              Text(
                'Please enter your email adress and we will send you a password reset link.',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Email(
                onNameChange: (value) {
                  setState(() {
                    _enteredEmail = value;
                  });
                },
              ),
              SizedBox(
                height: screenSize.height * 0.04,
              ),
              _isForget
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: screenSize.width * 0.32,
                          vertical: screenSize.height * 0.015,
                        ),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                      onPressed: forgotPassword,
                      child: Text(
                        'Reset ',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontSize: screenSize.width * 0.05,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
