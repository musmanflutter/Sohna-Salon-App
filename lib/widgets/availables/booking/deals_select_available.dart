import 'package:flutter/material.dart';

import 'package:sohna_salon_app/models/deal_class.dart';

class DealsSelectAvailable extends StatefulWidget {
  const DealsSelectAvailable(
      {super.key,
      required this.dealItems,
      required this.selectedDeals,
      required this.onTotalPriceChanged,
      required this.onSelectDeal});
  final List<DealClass> dealItems;
  final Set<DealClass> selectedDeals;
  final Function(double) onTotalPriceChanged;
  final Function(List<DealClass>) onSelectDeal;

  @override
  State<DealsSelectAvailable> createState() => _DealsSelectAvailableState();
}

class _DealsSelectAvailableState extends State<DealsSelectAvailable> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(
        left: screenSize.width * 0.05,
        right: screenSize.width * 0.05,
        top: screenSize.height * 0.01,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
        ),
        borderRadius: BorderRadius.circular(15),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      height: screenSize.height * 0.27,
      child: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
        ),
        itemCount: widget.dealItems.length,
        itemBuilder: (context, index) {
          final deal = widget.dealItems[index];
          final isSelected = widget.selectedDeals.contains(deal);
          return Column(
            children: [
              Container(
                height: screenSize.height * 0.07,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                child: Stack(
                  children: [
                    Text(
                      deal.dealTitle,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    Positioned(
                      top: screenSize.height * 0.035,
                      child: Text(
                        'PKR: ${deal.dealPrice.toString()}',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                            ),
                      ),
                    ),
                    Positioned(
                      right: screenSize.width * 0.0,
                      child: Switch(
                        activeColor: Theme.of(context).colorScheme.primary,
                        value: isSelected,
                        onChanged: (value) {
                          setState(() {
                            if (value) {
                              widget.selectedDeals.add(deal); // Select the deal
                              widget.onTotalPriceChanged(
                                  double.parse(deal.dealPrice));
                            } else {
                              widget.selectedDeals
                                  .remove(deal); // Deselect the deal
                              widget.onTotalPriceChanged(
                                  -double.parse(deal.dealPrice));
                            }
                            widget.onSelectDeal(widget.selectedDeals.toList());
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
