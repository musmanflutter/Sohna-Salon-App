import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sohna_salon_app/provider/load_orders.dart';

import 'package:sohna_salon_app/widgets/availables/other/build_error.dart';
import 'package:sohna_salon_app/widgets/availables/other/build_loading.dart';

import 'package:sohna_salon_app/widgets/availables/other/special_available/booked_screen_available.dart';

class BookedScreen extends ConsumerWidget {
  const BookedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appointmentsAsyncValue = ref.watch(orderProvider);

    return Consumer(
      builder: (context, ref, child) {
        return appointmentsAsyncValue.when(
          data: (data) {
            return BookedScreenAvailable(orderItems: data);
          },
          error: (error, stackTrace) => BuildError(error: error.toString()),
          loading: () => const BuildLoading(),
        );
      },
    );
  }
}
