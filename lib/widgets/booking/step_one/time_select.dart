import 'package:flutter/material.dart';

class TimeSelect extends StatefulWidget {
  const TimeSelect({super.key, required this.timeSelected});
  final Function(String) timeSelected;

  @override
  State<TimeSelect> createState() => _TimeSelectState();
}

class _TimeSelectState extends State<TimeSelect> {
  String _selectedTime = '';
  final List<String> _timeSlots = [
    '10:00 AM',
    '11:00 AM',
    '12:00 PM',
    '1:00 PM',
    '2:00 PM',
    '3:00 PM',
    '4:00 PM',
    '5:00 PM',
    '6:00 PM',
    '7:00 PM',
    '8:00 PM',
    '9:00 PM',
    '10:00 PM',
    '11:00 PM',
    '12:00 AM',
  ];
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SizedBox(
      height: (screenSize.height - MediaQuery.of(context).padding.top) * 0.05,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _timeSlots.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedTime = _timeSlots[index];
              });
              widget.timeSelected(_selectedTime);
            },
            child: Container(
              width: screenSize.width * 0.25,
              margin: EdgeInsets.symmetric(horizontal: screenSize.width * 0.01),
              decoration: BoxDecoration(
                border: Border.all(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.3)),
                borderRadius: BorderRadius.circular(15),
                color: _selectedTime != _timeSlots[index]
                    ? Theme.of(context).colorScheme.primaryContainer
                    : Theme.of(context).colorScheme.primary,
              ),
              alignment: Alignment.center,
              child: Text(_timeSlots[index],
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: _selectedTime != _timeSlots[index]
                            ? Theme.of(context).colorScheme.onPrimaryContainer
                            : Theme.of(context).colorScheme.onPrimary,
                      )),
            ),
          );
        },
      ),
    );
  }
}
