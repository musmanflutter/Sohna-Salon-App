import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sohna_salon_app/dummy.dart';
import 'package:sohna_salon_app/provider/others_index.dart';

import 'package:sohna_salon_app/screens/special_screens/about_screen.dart';
import 'package:sohna_salon_app/screens/special_screens/booked_screen.dart';
import 'package:sohna_salon_app/screens/special_screens/developer_screen.dart';
import 'package:sohna_salon_app/screens/special_screens/faqs_screen.dart';
import 'package:sohna_salon_app/screens/special_screens/feedback_screen.dart';
import 'package:sohna_salon_app/screens/special_screens/rating_and_review_screen.dart';
import 'package:sohna_salon_app/screens/special_screens/location_screen.dart';

class SpecialScreen extends ConsumerWidget {
  const SpecialScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(othersIndex);
    final screenSize = MediaQuery.of(context).size;

    final appBar = AppBar(
      actions: [
        Visibility(
          visible: selectedIndex == 1,
          child: IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const FeedbackScreen(),
              ));
            },
            icon: Icon(
              Icons.feedback_rounded,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        )
      ],
      toolbarHeight:
          (screenSize.height - MediaQuery.of(context).padding.top) * 0.1,
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      centerTitle: true,
      title: Text(dummyDrawer['labels']![selectedIndex]),
    );
    Widget? activeScreen;
    switch (selectedIndex) {
      case 0:
        activeScreen = const BookedScreen();
        break;

      case 1:
        activeScreen = const RatingReviewScreen();
        break;

      case 2:
        activeScreen = const FAQsScreen();
        break;

      case 3:
        activeScreen = const LocationScreen();
        break;

      case 4:
        activeScreen = const AboutScreen();
        break;

      case 5:
        activeScreen = const DeveloperScreen();
        break;
    }

    return Scaffold(
      appBar: appBar,
      body: Stack(
        children: [
          Container(
            color: Theme.of(context).colorScheme.primary,
          ),
          Container(
            padding: EdgeInsets.only(
              top: screenSize.height * 0.02,
              right: screenSize.width * 0.03,
              left: screenSize.width * 0.03,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background.withOpacity(0.95),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(25),
              ),
            ),
            child: activeScreen,
          ),
        ],
      ),
    );
  }
}
