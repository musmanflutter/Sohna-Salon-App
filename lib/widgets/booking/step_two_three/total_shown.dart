import 'package:flutter/material.dart';

class TotalShown extends StatelessWidget {
  const TotalShown({super.key, required this.totalPrice});
  final double totalPrice;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Total: ',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
        ),
        Text(
          '${totalPrice.toInt()} Rs',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onBackground,
              ),
        )
      ],
    );
  }
}
