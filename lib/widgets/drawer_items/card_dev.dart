import 'package:flutter/material.dart';

class CardDev extends StatelessWidget {
  const CardDev({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return SizedBox(
      width: double.infinity,
      child: Card(
        color: const Color.fromARGB(255, 255, 239, 238),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.all(screenSize.width * 0.02),
          child: Stack(
            children: [
              CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                radius: screenSize.width * 0.103,
                child: CircleAvatar(
                  backgroundImage:
                      const AssetImage('assets/images/developer.jpeg'),
                  radius: screenSize.width * 0.1,
                ),
              ),
              Positioned(
                left: screenSize.width * 0.26,
                top: screenSize.height * 0.01,
                child: Text(
                  'Muhammad Usman',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: screenSize.width * 0.062,
                      ),
                ),
              ),
              Positioned(
                left: screenSize.width * 0.26,
                top: screenSize.height * 0.055,
                child: Text(
                  'Flutter Developer',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontSize: screenSize.width * 0.046,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
