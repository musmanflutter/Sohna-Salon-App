import 'package:flutter/material.dart';

import 'package:sohna_salon_app/widgets/login/other/forgot_form.dart';

class ForgotScreen extends StatelessWidget {
  const ForgotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
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
                  top: screenSize.height * 0.03,
                ),
                alignment: Alignment.topLeft,
                child: IconButton(
                  style: IconButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: screenSize.height * 0.08,
                ),
                width: screenSize.width * 0.4,
                child: Image.asset('assets/images/logo.png'),
              ),
              const ForgotForm(),
            ],
          ),
        ),
      ),
    );
  }
}
