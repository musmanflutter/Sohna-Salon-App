import 'package:flutter/material.dart';

import 'package:sohna_salon_app/widgets/home/deals.dart';
import 'package:sohna_salon_app/widgets/home/rating_review.dart';
import 'package:sohna_salon_app/widgets/home/services.dart';
import 'package:sohna_salon_app/widgets/home/specialist.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final Widget space = SizedBox(
      height: (screenSize.height - MediaQuery.of(context).padding.top) * 0.02,
    );

    return SingleChildScrollView(
      child: Column(
        children: [
          const Services(),
          space,
          const Deals(),
          space,
          const Specialist(),
          space,
          const RatingReview(),
          SizedBox(
            height: (screenSize.height - MediaQuery.of(context).padding.top) *
                0.105,
          ),
        ],
      ),
    );
  }
}
