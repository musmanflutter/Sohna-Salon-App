import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Logout extends StatelessWidget {
  const Logout({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return ListTile(
      leading: Image.asset(
        'assets/icons/drawer/arrow.png',
        color: Theme.of(context).colorScheme.primary,
        height:
            (screenSize.height - MediaQuery.of(context).padding.top) * 0.035,
      ),
      title: Text(
        'Sign Out',
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Colors.black,
            ),
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: Text(
              'Logout',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            content: Text(
              'Are you sure you want to logout?',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            actions: [
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('No'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
                onPressed: () async {
                  final poping = Navigator.of(context);
                  await GoogleSignIn().signOut();
                  await FirebaseAuth.instance.signOut();
                  final prefs = await SharedPreferences.getInstance();
                  prefs.clear();

                  poping.popUntil((route) => route.isFirst);
                },
                child: const Text('Yes'),
              ),
            ],
          ),
        );
      },
    );
  }
}
