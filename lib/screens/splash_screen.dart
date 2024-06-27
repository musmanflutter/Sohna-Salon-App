import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:sohna_salon_app/screens/login/login_screen.dart';
import 'package:sohna_salon_app/screens/login/verification_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) {
            return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                //if have an error
                if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text(snapshot.error.toString()),
                    ),
                  );
                }

                //if data is loading
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                //if have data, means login
                if (snapshot.hasData) {
                  return const VerificationScreen();
                }

                //if doesnt have data, means not logged in
                return const LoginScreen();
              },
            );
          },
        ),
      );
    });
    return Scaffold(
      body: Container(
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
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: screenSize.width * 0.4,
                child: Image.asset('assets/images/logo.png'),
              ),
              LoadingAnimationWidget.prograssiveDots(
                color: Theme.of(context).colorScheme.onPrimary,
                size: screenSize.height * 0.12,
              )
            ],
          ),
        ),
      ),
    );
  }
}
