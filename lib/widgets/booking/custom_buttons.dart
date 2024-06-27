import 'package:flutter/material.dart';

class CustomButtons extends StatelessWidget {
  const CustomButtons(
      {super.key,
      required this.currentStep,
      required this.totalPrice,
      required this.selectedTime,
      required this.details,
      required this.isAuthenticating});
  final int currentStep;
  final double totalPrice;
  final String selectedTime;
  final ControlsDetails details;
  final bool isAuthenticating;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(top: screenSize.height * 0.01),
      child: Row(
        children: [
          Expanded(
            child: isAuthenticating
                ? Container(
                    height: screenSize.height * 0.05,
                    width: screenSize.width * 0.1,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(),
                  )
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    ),
                    onPressed: currentStep == 0 && selectedTime.isEmpty
                        ? () {
                            ScaffoldMessenger.of(context).clearSnackBars();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                duration: Duration(milliseconds: 800),
                                content:
                                    Text('Please select a time slot first'),
                              ),
                            );
                          }
                        : currentStep == 2 && totalPrice == 0
                            ? () {
                                ScaffoldMessenger.of(context).clearSnackBars();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    duration: Duration(milliseconds: 800),
                                    content: Text(
                                        'Please select a sevice or deal first'),
                                  ),
                                );
                              }
                            : details.onStepContinue,
                    child: currentStep < 3
                        ? const Text('Next')
                        : const Text('Finish'),
                  ),
          ),
          SizedBox(
            width: screenSize.width * 0.03,
          ),
          if (currentStep != 0)
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                onPressed: details.onStepCancel,
                child: const Text('Back'),
              ),
            ),
        ],
      ),
    );
  }
}
