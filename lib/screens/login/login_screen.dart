import 'package:flutter/material.dart';

import 'package:sohna_salon_app/widgets/login/other/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: screenSize.height * 0.04,
                ),
                width: screenSize.width * 0.4,
                child: Image.asset('assets/images/logo.png'),
              ),
              const LoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}
