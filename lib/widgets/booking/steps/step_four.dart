import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:sohna_salon_app/models/deal_class.dart';
import 'package:sohna_salon_app/models/service_class.dart';

class StepFour extends StatelessWidget {
  const StepFour({
    super.key,
    required this.date,
    required this.time,
    required this.services,
    required this.deals,
    required this.total,
  });

  final DateTime date;
  final String time;
  final List<ServiceClass> services;
  final List<DealClass> deals;
  final double total;

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('EEE, dd/MM/y').format(date);
    final screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(
          left: screenSize.width * 0.05,
          right: screenSize.width * 0.05,
          top: screenSize.height * 0.01),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
        ),
        borderRadius: BorderRadius.circular(15),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      height: screenSize.height * 0.3,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Confirmation',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Selected Date:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              formattedDate,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Selected Time:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              time,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Selected Services:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            services.isEmpty
                ? const Text('No services added')
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: services.map((service) {
                      // updateServicesNames(service.serviceTitle);
                      return Text(
                        '- ${service.serviceTitle}',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      );
                    }).toList(),
                  ),
            const SizedBox(height: 16),
            const Text(
              'Selected Deals:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            deals.isEmpty
                ? const Text('No deals added')
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: deals.map((deal) {
                      return Text(
                        '- ${deal.dealTitle}',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      );
                    }).toList(),
                  ),
            const SizedBox(height: 16),
            const Text(
              'Total:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Rs ${total.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
