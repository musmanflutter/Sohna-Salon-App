import 'package:flutter/material.dart';
import 'package:sohna_salon_app/models/deal_class.dart';
import 'package:sohna_salon_app/widgets/booking/step_two_three/deals_select.dart';
import 'package:sohna_salon_app/widgets/booking/step_two_three/total_shown.dart';

class StepThree extends StatelessWidget {
  const StepThree({
    super.key,
    required this.updateTotalPrice,
    required this.updateSelectedDeals,
    required this.totalPrice,
  });
  final Function(double) updateTotalPrice;
  final Function(List<DealClass>) updateSelectedDeals;
  final double totalPrice;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        DealSelect(
          onTotalPriceChanged: updateTotalPrice,
          onSelectDeal: updateSelectedDeals,
        ),
        SizedBox(
          height: screenSize.height * 0.008,
        ),
        TotalShown(totalPrice: totalPrice),
      ],
    );
  }
}
