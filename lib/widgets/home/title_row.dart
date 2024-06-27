import 'package:flutter/material.dart';

class TitleRow extends StatelessWidget {
  const TitleRow(
      {super.key,
      required this.text,
      required this.changeIndex,
      required this.index});
  final String text;
  final Function(int) changeIndex;
  final int index;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
        ),
        const Spacer(),
        if (index <= 2)
          TextButton(
            style: TextButton.styleFrom(
              alignment: Alignment.topRight,
              padding: EdgeInsets.only(left: screenSize.width * 0.04),
            ),
            onPressed: () {
              changeIndex(index);
            },
            child: Text(
              'View all',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ),
      ],
    );
  }
}
