import 'package:flutter/material.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: screenSize.width * 0.75,
        padding: EdgeInsets.symmetric(
          vertical: screenSize.height * 0.014,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
          ),
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/social/google.png',
              color: Theme.of(context).colorScheme.primary,
              height: (screenSize.height - MediaQuery.of(context).padding.top) *
                  0.032,
            ),
            SizedBox(
              width: screenSize.width * 0.035,
            ),
            Text(
              'Continue with Google',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: screenSize.width * 0.05,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
