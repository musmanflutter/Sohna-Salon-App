import 'package:flutter/material.dart';

class BuildError extends StatelessWidget {
  const BuildError({super.key, required this.error});
  final dynamic error;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return SizedBox(
      height: (screenSize.height - MediaQuery.of(context).padding.top) * 0.9,
      child: Center(
        child: Text(
          'Please restart the app to fetch data properly',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
