import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sohna_salon_app/provider/load_specialist.dart';
import 'package:sohna_salon_app/provider/selected_index.dart';

import 'package:sohna_salon_app/widgets/availables/other/build_error.dart';
import 'package:sohna_salon_app/widgets/availables/other/build_loading.dart';
import 'package:sohna_salon_app/widgets/availables/home/specialists_available.dart';

class Specialist extends ConsumerWidget {
  const Specialist({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final specialistAsyncValue = ref.watch(specialistProvider);
    void changeIndex(int index) {
      ref.read(indexProvider.notifier).updateIndex(index);
    }

    return Consumer(
      builder: (context, ref, child) {
        return specialistAsyncValue.when(
          data: (data) {
            return SpecialistsAvailable(
                specialistItems: data, changeIndex: changeIndex);
          },
          error: (error, stackTrace) => BuildError(error: error),
          loading: () => const BuildLoading(),
        );
      },
    );
  }
}
