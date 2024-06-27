import 'package:flutter/material.dart';

class PrefixIcon extends StatelessWidget {
  const PrefixIcon({super.key, required this.icon});
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
        ),
        SizedBox(
          width: screenSize.width * 0.01,
        ),
        Container(
          height: screenSize.height * 0.022,
          width: 2,
          color: Theme.of(context).colorScheme.primary,
        )
      ],
    );
  }
}
