import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sohna_salon_app/provider/load_deal.dart';
import 'package:sohna_salon_app/provider/selected_index.dart';

import 'package:sohna_salon_app/widgets/availables/other/build_error.dart';
import 'package:sohna_salon_app/widgets/availables/other/build_loading.dart';
import 'package:sohna_salon_app/widgets/availables/other/common_available/deal_screen_available.dart';

class DealsScreen extends ConsumerWidget {
  const DealsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dealsAsyncValue = ref.watch(dealsProvider);
    void changeIndex(int num) {
      ref.read(indexProvider.notifier).updateIndex(num);
    }

    return Consumer(
      builder: (context, ref, child) {
        return dealsAsyncValue.when(
          data: (data) {
            return DealScreenAvailable(
                dealItems: data, changeIndex: changeIndex);
          },
          error: (error, stackTrace) => BuildError(error: error),
          loading: () => const BuildLoading(),
        );
      },
    );
  }
}
