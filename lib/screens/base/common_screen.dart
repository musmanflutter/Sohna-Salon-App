import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:sohna_salon_app/dummy.dart';
import 'package:sohna_salon_app/provider/selected_index.dart';

import 'package:sohna_salon_app/screens/common_screens/bookings_screen.dart';
import 'package:sohna_salon_app/screens/common_screens/deals_screen.dart';
import 'package:sohna_salon_app/screens//common_screens/home_screen.dart';
import 'package:sohna_salon_app/screens/common_screens/services_screen.dart';

import 'package:sohna_salon_app/widgets/drawer/my_drawer.dart';
import 'package:sohna_salon_app/widgets/other/nav_bar.dart';

class CommonScreen extends ConsumerWidget {
  const CommonScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String phoneNumber = '03158466285';
    void launchWhatsApp() async {
      final whatsAppUrl = Uri.parse('https://wa.me/$phoneNumber');
      if (await canLaunchUrl(whatsAppUrl)) {
        await launchUrl(whatsAppUrl);
      } else {
        throw 'Could not launch $whatsAppUrl';
      }
    }

    final selectedIndex = ref.watch(indexProvider);
    final screenSize = MediaQuery.of(context).size;

    final appBar = AppBar(
      toolbarHeight:
          (screenSize.height - MediaQuery.of(context).padding.top) * 0.1,
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      centerTitle: true,
      title: Text(dummyIcons['labels']![selectedIndex]),
      actions: [
        IconButton(
          onPressed: () {
            launchWhatsApp();
          },
          icon: const Icon(
            Icons.send_rounded,
          ),
        )
      ],
    );
    Widget? activeScreen;
    switch (selectedIndex) {
      case 0:
        activeScreen = const HomeScreen();
        break;
      case 1:
        activeScreen = const ServicesScreen();
        break;
      case 2:
        activeScreen = const DealsScreen();
        break;
      case 3:
        activeScreen = const BookingScreen();
        break;
    }

    return PopScope(
      canPop: selectedIndex == 0,
      onPopInvoked: (didPop) {
        if (!didPop && selectedIndex != 0) {
          // If back navigation was canceled and not on home screen, navigate to home screen
          ref.read(indexProvider.notifier).updateIndex(0);
        }
      },
      child: Scaffold(
        appBar: appBar,
        drawer: const MyDrawer(),
        body: Stack(
          children: [
            Container(
              color: Theme.of(context).colorScheme.primary,
            ),
            Container(
              padding: EdgeInsets.only(
                top: selectedIndex == 3 ? 0 : screenSize.height * 0.015,
                right: selectedIndex == 3 ? 0 : screenSize.width * 0.03,
                left: selectedIndex == 3 ? 0 : screenSize.width * 0.03,
              ),
              decoration: BoxDecoration(
                color:
                    Theme.of(context).colorScheme.background.withOpacity(0.95),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(25),
                ),
              ),
              child: activeScreen,
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: NavBar(),
            ),
          ],
        ),
      ),
    );
  }
}
