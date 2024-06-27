import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class Contacts extends StatelessWidget {
  const Contacts({super.key, required this.phoneNumber});
  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    const email = 'umuhammad662@gmail.com';
    List<String> imageLink = [
      'assets/icons/contact/telephone.png',
      'assets/icons/contact/whatsapp.png',
    ];

    if (phoneNumber == '03119843011') {
      imageLink.add('assets/icons/contact/email.png');
    }

    void launchPhoneCall() async {
      final phoneUrl = Uri(scheme: 'tel', path: phoneNumber);
      if (await canLaunchUrl(phoneUrl)) {
        await launchUrl(phoneUrl);
      } else {
        throw 'Could not launch $phoneUrl';
      }
    }

    void launchEmail() async {
      final emailUrl = Uri(scheme: 'mailto', path: email);
      if (await canLaunchUrl(emailUrl)) {
        await launchUrl(emailUrl);
      } else {
        throw 'Could not launch $emailUrl';
      }
    }

    void launchWhatsApp() async {
      final whatsAppUrl = Uri.parse('https://wa.me/$phoneNumber');
      if (await canLaunchUrl(whatsAppUrl)) {
        await launchUrl(whatsAppUrl);
      } else {
        throw 'Could not launch $whatsAppUrl';
      }
    }

    return Container(
        margin: EdgeInsets.symmetric(
          horizontal: screenSize.width * 0.015,
          vertical:
              (screenSize.height - MediaQuery.of(context).padding.top) * 0.01,
        ),
        child: Column(
          children: List.generate(
            imageLink.length,
            (index) => SizedBox(
              // color: Colors.amber,
              height: (screenSize.height) * 0.048,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    imageLink[index],
                    height: screenSize.height * 0.03,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      alignment: Alignment.topCenter,
                      // backgroundColor: Colors.blue,
                      padding: const EdgeInsets.only(left: 10),
                    ),
                    onPressed: () {
                      if (index == 0) {
                        launchPhoneCall();
                      } else if (index == 1) {
                        launchWhatsApp();
                      } else {
                        launchEmail();
                      }
                    },
                    child: Text(
                      index <= 1 ? phoneNumber : email,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: const Color.fromARGB(255, 0, 8, 162),
                            fontSize: index <= 1
                                ? screenSize.width * 0.043
                                : screenSize.width * 0.05,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
