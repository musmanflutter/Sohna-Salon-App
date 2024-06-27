import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class DateSelect extends StatefulWidget {
  const DateSelect({super.key, required this.selectedDate});
  final Function(DateTime) selectedDate;

  @override
  State<DateSelect> createState() => _DateSelectState();
}

class _DateSelectState extends State<DateSelect> {
  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
      widget.selectedDate(today);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TableCalendar(
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
          weekendStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        onDaySelected: _onDaySelected,
        selectedDayPredicate: (day) => isSameDay(day, today),
        calendarStyle: CalendarStyle(
          selectedDecoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        headerStyle: HeaderStyle(
          headerMargin: EdgeInsets.only(
              bottom: (screenSize.height - MediaQuery.of(context).padding.top) *
                  0.01),
          headerPadding: EdgeInsets.symmetric(
              vertical:
                  (screenSize.height - MediaQuery.of(context).padding.top) *
                      0.001),
          leftChevronIcon: Icon(
            Icons.chevron_left,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          rightChevronIcon: Icon(
            Icons.chevron_right,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          titleTextStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(15),
            ),
          ),
          formatButtonVisible: false,
          titleCentered: true,
        ),
        rowHeight:
            (screenSize.height - MediaQuery.of(context).padding.top) * 0.055,
        focusedDay: today,
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
      ),
    );
  }
}
