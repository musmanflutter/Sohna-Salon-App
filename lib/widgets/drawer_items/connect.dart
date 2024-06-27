import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:sohna_salon_app/dummy.dart';

class Connect extends StatelessWidget {
  const Connect({super.key, required this.num});
  final int num;

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

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: screenSize.width * 0.015,
        vertical:
            (screenSize.height - MediaQuery.of(context).padding.top) * 0.03,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          dummySocials[num].imageAdress.length,
          (index) => InkWell(
            onTap: () {
              launchWebs(dummySocials[num].imageLink[index]);
            },
            child: Container(
              clipBehavior: Clip.hardEdge,
              height: screenSize.height * 0.065,
              width: screenSize.height * 0.065,
              margin: EdgeInsets.symmetric(horizontal: screenSize.width * 0.03),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              ),
              child: Image.asset(dummySocials[num].imageAdress[index]),
            ),
          ),
        ),
      ),
    );
  }
}
