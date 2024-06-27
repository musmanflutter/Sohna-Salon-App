import 'package:flutter/material.dart';

import 'package:sohna_salon_app/widgets/drawer_items/card_dev.dart';
import 'package:sohna_salon_app/widgets/drawer_items/connect.dart';
import 'package:sohna_salon_app/widgets/drawer_items/contact.dart';
import 'package:url_launcher/url_launcher.dart';

class DeveloperScreen extends StatelessWidget {
  const DeveloperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    void launchWebs(String webAdress) async {
      final web = Uri.parse(webAdress);
      if (await canLaunchUrl(web)) {
        await launchUrl(web);
      } else {
        throw 'Could not launch $web';
      }
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CardDev(),
          SizedBox(
            height:
                (screenSize.height - MediaQuery.of(context).padding.top) * 0.02,
          ),
          Text(
            'About Me:',
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
            child: Column(
              children: [
                Text(
                  'Skilled Flutter developer crafting visually stunning apps with expertise in Flutter. Proficient in Firebase for basic backend functionalities. Dedicated to creating seamless user experiences and staying updated with the latest trends. Let\'s bring your app ideas to life!',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
                SizedBox(
                  height:
                      (screenSize.height - MediaQuery.of(context).padding.top) *
                          0.02,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    ),
                    onPressed: () {
                      launchWebs(
                          'https://www.linkedin.com/in/muhammad-usman-flutter-developer/');
                    },
                    child: Text(
                      'Visit Portfolio',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
              ],
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
            phoneNumber: '03119843011',
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
          const Connect(num: 1),
          SizedBox(
            height:
                (screenSize.height - MediaQuery.of(context).padding.top) * 0.02,
          ),
        ],
      ),
    );
  }
}
