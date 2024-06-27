import 'package:flutter/material.dart';

import 'package:sohna_salon_app/models/service_class.dart';
import 'package:sohna_salon_app/widgets/booking/step_two_three/service_select.dart';
import 'package:sohna_salon_app/widgets/booking/step_two_three/total_shown.dart';

class StepTwo extends StatelessWidget {
  const StepTwo({
    super.key,
    required this.updateTotalPrice,
    required this.updateSelectedServices,
    required this.totalPrice,
  });
  final Function(double) updateTotalPrice;
  final Function(List<ServiceClass>) updateSelectedServices;
  final double totalPrice;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Column(
      children: [
        ServiceSelect(
          onTotalPriceChanged: updateTotalPrice,
          onSelectService: updateSelectedServices,
        ),
        SizedBox(
          height: screenSize.height * 0.008,
        ),
        TotalShown(totalPrice: totalPrice),
      ],
    );
  }
}
