import 'package:flutter/material.dart';

import 'package:sohna_salon_app/models/faq_class.dart';
import 'package:sohna_salon_app/widgets/drawer_items/list_faq.dart';

class FaqScreenAvailable extends StatelessWidget {
  const FaqScreenAvailable({super.key, required this.faqItems});
  final List<FaqClass> faqItems;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return faqItems.isEmpty
        ? SizedBox(
            height:
                (screenSize.height - MediaQuery.of(context).padding.top) * 0.9,
            child: Center(
              child: Text(
                'No Faqs added  yet',
                style: Theme.of(context).textTheme.titleLarge!,
              ),
            ),
          )
        : Column(
            children: [Expanded(child: ListFaq(faqItems: faqItems))],
          );
  }
}
