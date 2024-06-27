import 'package:flutter/material.dart';

import 'package:sohna_salon_app/widgets/drawer_items/map_shown.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Adress',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
        ),
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: screenSize.width * 0.015,
            vertical:
                (screenSize.height - MediaQuery.of(context).padding.top) * 0.01,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.location_on,
                size: (screenSize.height - MediaQuery.of(context).padding.top) *
                    0.064,
              ),
              Expanded(
                child: Text(
                  'Plot A4/7, Moinabad, M.M Alam Road,Near Malir Cantt Check Post No 2, Near Zaidi Manzil Bus Stop, Model Colony, Karachi.',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height:
              (screenSize.height - MediaQuery.of(context).padding.top) * 0.02,
        ),
        Text(
          'Map',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
        ),
        const MapShown(),
      ],
    );
  }
}
