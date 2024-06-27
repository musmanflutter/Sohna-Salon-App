import 'package:flutter/material.dart';

class LastLine extends StatelessWidget {
  const LastLine({super.key, required this.isLogin, required this.onTap});
  final bool isLogin;
  final Function(bool) onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isLogin ? 'Don\'t have an account?' : 'Already have an account?',
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Colors.black87,
              ),
        ),
        const SizedBox(
          width: 5,
        ),
        InkWell(
          splashColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          onTap: () {
            onTap(!isLogin);
          },
          child: Container(
            alignment: Alignment.center,
            height: 25,
            width: 53,
            child: Text(
              isLogin ? 'Sign up' : 'Sign in',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
