import 'package:flutter/material.dart';

import 'package:sohna_salon_app/models/faq_class.dart';

class ListFaq extends StatefulWidget {
  final List<FaqClass> faqItems;

  const ListFaq({
    required this.faqItems,
    super.key,
  });

  @override
  State<ListFaq> createState() => _ListFaqState();
}

class _ListFaqState extends State<ListFaq> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return ListView.builder(
      itemCount: widget.faqItems.length,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.only(
          bottom:
              (screenSize.height - MediaQuery.of(context).padding.top) * 0.02,
        ),
        child: Card(
          color: Theme.of(context).colorScheme.primaryContainer,
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: ExpansionTile(
              collapsedIconColor: Theme.of(context).colorScheme.primary,
              tilePadding:
                  EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
              childrenPadding:
                  EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
              title: Text(
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                widget.faqItems[index].faqQuestion,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
              ),
              children: [
                Text(
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  widget.faqItems[index].faqAnswer,
                  style: TextStyle(
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
