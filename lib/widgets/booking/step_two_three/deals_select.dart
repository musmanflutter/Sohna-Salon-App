import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sohna_salon_app/widgets/availables/booking/deals_select_available.dart';
import 'package:sohna_salon_app/widgets/availables/other/build_error.dart';
import 'package:sohna_salon_app/widgets/availables/other/build_loading.dart';

import 'package:sohna_salon_app/models/deal_class.dart';
import 'package:sohna_salon_app/provider/load_deal.dart';

class DealSelect extends ConsumerStatefulWidget {
  final Function(double) onTotalPriceChanged;
  final Function(List<DealClass>) onSelectDeal;
  const DealSelect({
    super.key,
    required this.onTotalPriceChanged,
    required this.onSelectDeal,
  });

  @override
  ConsumerState<DealSelect> createState() => _DealSelectState();
}

class _DealSelectState extends ConsumerState<DealSelect> {
  Set<DealClass> selectedDeals = {};
  @override
  Widget build(BuildContext context) {
    final dealsAsyncValue = ref.watch(dealsProvider);

    return Consumer(
      builder: (context, ref, child) {
        return dealsAsyncValue.when(
          data: (data) {
            return DealsSelectAvailable(
                dealItems: data,
                selectedDeals: selectedDeals,
                onTotalPriceChanged: widget.onTotalPriceChanged,
                onSelectDeal: widget.onSelectDeal);
          },
          error: (error, stackTrace) => BuildError(error: error),
          loading: () => const BuildLoading(),
        );
      },
    );
  }
}
