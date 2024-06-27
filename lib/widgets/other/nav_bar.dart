import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sohna_salon_app/dummy.dart';
import 'package:sohna_salon_app/provider/selected_index.dart';

class NavBar extends ConsumerStatefulWidget {
  const NavBar({super.key});

  @override
  ConsumerState<NavBar> createState() => _NavBarState();
}

class _NavBarState extends ConsumerState<NavBar> {
  void changeIndex(int index) {
    setState(() {
      ref.read(indexProvider.notifier).updateIndex(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = ref.watch(indexProvider);

    final screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.height * 0.08,
      margin: EdgeInsets.only(
        right: screenSize.width * 0.03,
        left: screenSize.width * 0.03,
        bottom: screenSize.height * 0.02,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(30),
            blurRadius: 20,
            spreadRadius: screenSize.height * 0.01,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          dummyIcons['icons']!.length,
          (index) => InkWell(
            onTap: () {
              changeIndex(index);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  height:
                      (screenSize.height - MediaQuery.of(context).padding.top) *
                          0.043,
                  width: screenSize.width * 0.15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: selectedIndex == index
                        ? Colors.white.withOpacity(0.3)
                        : Colors.transparent,
                  ),
                  child: Image.asset(
                    height: (screenSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.03,
                    dummyIcons['icons']![index],
                    color: selectedIndex == index
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context)
                            .colorScheme
                            .onPrimary
                            .withOpacity(0.8),
                  ),
                ),
                Text(
                  dummyIcons['labels']![index],
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: selectedIndex == index
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context)
                                .colorScheme
                                .onPrimary
                                .withOpacity(0.8),
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
