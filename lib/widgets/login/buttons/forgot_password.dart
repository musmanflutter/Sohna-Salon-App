import 'package:flutter/material.dart';

import 'package:sohna_salon_app/screens/login/forgot_screen.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        splashColor: Theme.of(context).colorScheme.primary.withOpacity(0.4),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const ForgotScreen(),
          ));
        },
        child: Container(
          alignment: Alignment.center,
          height: 25,
          width: 120,
          child: Text(
            'Forgot password?',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ),
      ),
    );
  }
}
