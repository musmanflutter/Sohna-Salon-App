import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sohna_salon_app/widgets/availables/booking/services_select_available.dart';
import 'package:sohna_salon_app/widgets/availables/other/build_error.dart';
import 'package:sohna_salon_app/widgets/availables/other/build_loading.dart';

import 'package:sohna_salon_app/models/service_class.dart';
import 'package:sohna_salon_app/provider/load_service.dart';

class ServiceSelect extends ConsumerStatefulWidget {
  final Function(double) onTotalPriceChanged;
  final Function(List<ServiceClass>) onSelectService;
  const ServiceSelect(
      {super.key,
      required this.onTotalPriceChanged,
      required this.onSelectService});

  @override
  ConsumerState<ServiceSelect> createState() => _ServiceSelectState();
}

class _ServiceSelectState extends ConsumerState<ServiceSelect> {
  Set<ServiceClass> selectedServices = {};
  @override
  Widget build(BuildContext context) {
    final servicesAsyncValue = ref.watch(serviceProvider);

    return Consumer(
      builder: (context, ref, child) {
        return servicesAsyncValue.when(
          data: (data) {
            return ServicesSelectAvailable(
                serviceItems: data,
                selectedServices: selectedServices,
                onTotalPriceChanged: widget.onTotalPriceChanged,
                onSelectService: widget.onSelectService);
          },
          error: (error, stackTrace) => BuildError(error: error),
          loading: () => const BuildLoading(),
        );
      },
    );
  }
}
