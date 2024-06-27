import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sohna_salon_app/provider/load_service.dart';
import 'package:sohna_salon_app/provider/selected_index.dart';

import 'package:sohna_salon_app/widgets/availables/other/build_error.dart';
import 'package:sohna_salon_app/widgets/availables/other/build_loading.dart';
import 'package:sohna_salon_app/widgets/availables/other/common_available/services_screen_available.dart';

class ServicesScreen extends ConsumerWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final serviceAsyncValue = ref.watch(serviceProvider);
    void changeIndex(int num) {
      ref.read(indexProvider.notifier).updateIndex(num);
    }

    return Consumer(
      builder: (context, ref, child) {
        return serviceAsyncValue.when(
          data: (data) {
            return ServicesScreenAvailable(
              serviceItems: data,
              changeIndex: changeIndex,
            );
          },
          error: (error, stackTrace) => BuildError(error: error),
          loading: () => const BuildLoading(),
        );
      },
    );
  }
}
