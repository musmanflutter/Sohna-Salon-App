import 'package:flutter/material.dart';

import 'package:sohna_salon_app/widgets/drawer_items/connect.dart';
import 'package:sohna_salon_app/widgets/drawer_items/contact.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome to Our Salon!',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: screenSize.width * 0.015,
              vertical:
                  (screenSize.height - MediaQuery.of(context).padding.top) *
                      0.01,
            ),
            child: Text(
              'At Our Salon, we strive to provide the best hair and beauty services to our customers. With our team of skilled professionals and high-quality products, we aim to make every visit a memorable experience for you.',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
          ),
          SizedBox(
            height:
                (screenSize.height - MediaQuery.of(context).padding.top) * 0.02,
          ),
          Text(
            'Our Services:',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: screenSize.width * 0.015,
              vertical:
                  (screenSize.height - MediaQuery.of(context).padding.top) *
                      0.01,
            ),
            child: Text(
              '- Haircuts\n- Styling\n- Coloring\n- Makeup\n- Skincare\n- And Much More...',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
          ),
          SizedBox(
            height:
                (screenSize.height - MediaQuery.of(context).padding.top) * 0.02,
          ),
          Text(
            'Contact Us:',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const Contacts(
            phoneNumber: '03158466285',
          ),
          SizedBox(
            height:
                (screenSize.height - MediaQuery.of(context).padding.top) * 0.02,
          ),
          Text(
            'Connect With Us:',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const Connect(
            num: 0,
          ),
          SizedBox(
            height:
                (screenSize.height - MediaQuery.of(context).padding.top) * 0.02,
          ),
        ],
      ),
    );
  }
}
