import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sohna_salon_app/provider/load_faq.dart';

import 'package:sohna_salon_app/widgets/availables/other/build_error.dart';
import 'package:sohna_salon_app/widgets/availables/other/build_loading.dart';
import 'package:sohna_salon_app/widgets/availables/other/special_available/faq_screen_available.dart';

class FAQsScreen extends ConsumerStatefulWidget {
  const FAQsScreen({super.key});

  @override
  ConsumerState<FAQsScreen> createState() => _FAQsScreenState();
}

class _FAQsScreenState extends ConsumerState<FAQsScreen> {
  @override
  Widget build(BuildContext context) {
    final faqAsyncValue = ref.watch(faqsProvider);
    return Consumer(
      builder: (context, ref, child) {
        return faqAsyncValue.when(
          data: (data) {
            return FaqScreenAvailable(
              faqItems: data,
            );
          },
          error: (error, stackTrace) => BuildError(error: error),
          loading: () => const BuildLoading(),
        );
      },
    );
  }
}
