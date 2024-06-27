import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sohna_salon_app/screens/base/common_screen.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;
  Timer? time;
  int countdownSeconds = 30;

  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();

      //call checkEmailVerified every 3 seconds
      timer = Timer.periodic(
        const Duration(seconds: 3),
        (timer) => checkEmailVerified(),
      );
    }
  }

  Future checkEmailVerified() async {
    //reload user
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() {
        canResendEmail = false;
      });
      startCountdown();
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    }
  }

  void startCountdown() {
    time = Timer.periodic(const Duration(seconds: 1), (Timer time) {
      setState(() {
        countdownSeconds--;
      });
      if (countdownSeconds == 0) {
        time.cancel();
        setState(() {
          // Enable resend button when countdown finishes
          canResendEmail = true;
        });
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    time?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return isEmailVerified
        ? const CommonScreen()
        : Scaffold(
            body: Container(
              alignment: Alignment.center,
              height: screenSize.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary.withOpacity(1),
                    Theme.of(context).colorScheme.primary.withOpacity(0.7),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 4,
                margin: EdgeInsets.all(screenSize.width * 0.04),
                child: Padding(
                  padding: EdgeInsets.all(screenSize.width * 0.05),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Verification Code Sent!\nWe\'ve sent a verification email to ${FirebaseAuth.instance.currentUser!.email}. Please check your inbox (and spam/junk folder, just in case!) and verify it to complete the process.\nIf you haven\'t received the email within 30 seconds, you can request a new verification email.',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: screenSize.height * 0.02),
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          icon: Icon(
                            Icons.email_rounded,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            backgroundColor: canResendEmail
                                ? Theme.of(context).colorScheme.primary
                                : Colors.grey,
                          ),
                          onPressed:
                              canResendEmail ? sendVerificationEmail : null,
                          label: Text(
                            canResendEmail
                                ? 'Resend Email'
                                : 'Resend in $countdownSeconds seconds',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fontSize: screenSize.width * 0.05,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () => FirebaseAuth.instance.signOut(),
                        child: const Text('Cancel'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
