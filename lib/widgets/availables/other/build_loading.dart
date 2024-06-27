import 'package:flutter/material.dart';

class BuildLoading extends StatelessWidget {
  const BuildLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SizedBox(
      height: (screenSize.height - MediaQuery.of(context).padding.top) * 0.9,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
