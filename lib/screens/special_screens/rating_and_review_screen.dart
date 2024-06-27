import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sohna_salon_app/provider/load_feedback.dart';
import 'package:sohna_salon_app/widgets/availables/other/build_error.dart';
import 'package:sohna_salon_app/widgets/availables/other/build_loading.dart';
import 'package:sohna_salon_app/widgets/availables/other/special_available/rating_screen_available.dart';

class RatingReviewScreen extends ConsumerWidget {
  const RatingReviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedbackAsyncValue = ref.watch(feedbackProvider);

    return Consumer(
      builder: (context, ref, child) {
        return feedbackAsyncValue.when(
          data: (data) {
            return RatingScreenAvailable(feedbackItems: data);
          },
          error: (error, stackTrace) => BuildError(error: error),
          loading: () => const BuildLoading(),
        );
      },
    );
  }
}
