import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sohna_salon_app/provider/load_feedback.dart';
import 'package:sohna_salon_app/provider/others_index.dart';
import 'package:sohna_salon_app/widgets/availables/home/rating_available.dart';
import 'package:sohna_salon_app/widgets/availables/other/build_error.dart';
import 'package:sohna_salon_app/widgets/availables/other/build_loading.dart';

class RatingReview extends ConsumerWidget {
  const RatingReview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedbackAsyncValue = ref.watch(feedbackProvider);

    void changeIndex(int index) {
      ref.read(othersIndex.notifier).updateIndex(index);
    }

    return Consumer(
      builder: (context, ref, child) {
        return feedbackAsyncValue.when(
          data: (data) {
            return RatingAvailable(
                feedbackItems: data, changeIndex: changeIndex);
          },
          error: (error, stackTrace) => BuildError(error: error),
          loading: () => const BuildLoading(),
        );
      },
    );
  }
}
