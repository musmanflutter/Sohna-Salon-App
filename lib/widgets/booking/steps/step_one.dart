import 'package:flutter/material.dart';

import 'package:sohna_salon_app/widgets/booking/step_one/date_select.dart';
import 'package:sohna_salon_app/widgets/booking/step_one/time_select.dart';

class StepOne extends StatelessWidget {
  const StepOne({
    super.key,
    required this.selectDate,
    required this.selectTime,
  });
  final Function(DateTime) selectDate;
  final Function(String) selectTime;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        DateSelect(selectedDate: selectDate),
        SizedBox(height: screenSize.height * 0.015),
        TimeSelect(timeSelected: selectTime),
      ],
    );
  }
}
