import 'package:flutter/material.dart';

import 'package:sohna_salon_app/models/service_class.dart';

class ServicesSelectAvailable extends StatefulWidget {
  const ServicesSelectAvailable({
    super.key,
    required this.serviceItems,
    required this.selectedServices,
    required this.onTotalPriceChanged,
    required this.onSelectService,
  });

  final List<ServiceClass> serviceItems;
  final Set<ServiceClass> selectedServices;
  final Function(double) onTotalPriceChanged;
  final Function(List<ServiceClass>) onSelectService;

  @override
  State<ServicesSelectAvailable> createState() =>
      _ServicesSelectAvailableState();
}

class _ServicesSelectAvailableState extends State<ServicesSelectAvailable> {
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
        itemCount: widget.serviceItems.length,
        itemBuilder: (context, index) {
          final service = widget.serviceItems[index];
          final isSelected = widget.selectedServices.contains(service);
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
                      service.serviceTitle,
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
                        'PKR: ${service.servicePrice.toString()}',
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
                              widget.selectedServices
                                  .add(service); // Select the service
                              widget.onTotalPriceChanged(
                                  double.parse(service.servicePrice));
                            } else {
                              widget.selectedServices
                                  .remove(service); // Deselect the service
                              widget.onTotalPriceChanged(
                                  -double.parse(service.servicePrice));
                            }
                            widget.onSelectService(
                                widget.selectedServices.toList());
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
