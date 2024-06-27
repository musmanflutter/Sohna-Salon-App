import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sohna_salon_app/dummy.dart';
import 'package:sohna_salon_app/provider/others_index.dart';
import 'package:sohna_salon_app/screens/base/special_screen.dart';

import 'package:sohna_salon_app/widgets/drawer/drawer_header_set.dart';
import 'package:sohna_salon_app/widgets/drawer/logout.dart';

class MyDrawer extends ConsumerStatefulWidget {
  const MyDrawer({super.key});

  @override
  ConsumerState<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends ConsumerState<MyDrawer> {
  void changeIndex(int index) {
    setState(() {
      ref.read(othersIndex.notifier).updateIndex(index);
    });
    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SpecialScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Drawer(
      width: screenSize.width * 0.7,
      child: Column(
        children: [
          const DrawerHeaderSet(),
          // ListView.separated(
          //   padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          //   shrinkWrap: true,
          //   itemCount: dummyDrawer(context)[0].text.length,
          //   separatorBuilder: (context, index) => Divider(
          // color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
          //   ), // Add a divider between list items
          //   itemBuilder: (context, index) => ListTile(
          //     leading: dummyDrawer(context)[0].drawerIcons[index],
          //     title: Text(
          //       dummyDrawer(context)[0].text[index],
          //       style: Theme.of(context).textTheme.titleLarge!.copyWith(
          //             color: isDarkMode
          //                 ? Theme.of(context).colorScheme.onBackground
          //                 : Colors.black,
          //           ),
          //     ),
          //     onTap: () {
          //       changeIndex(index);
          //     },
          //   ),
          // ),
          Column(
            children: List.generate(
              dummyDrawer['icons']!.length,
              (index) => Column(
                children: [
                  ListTile(
                    // tileColor: Colors.amber,
                    // selectedColor: Colors.black,
                    leading: Image.asset(
                      dummyDrawer['icons']![index],
                      color: Theme.of(context).colorScheme.primary,
                      height: (screenSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.035,
                    ),
                    title: Text(
                      dummyDrawer['labels']![index],
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Colors.black,
                          ),
                    ),
                    onTap: () {
                      changeIndex(index);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenSize.width * 0.05),
                    child: Divider(
                      height: 0,
                      color: Theme.of(context)
                          .colorScheme
                          .onPrimaryContainer
                          .withOpacity(0.25),
                    ),
                  )
                ],
              ),
            ),
          ),
          const Logout(),
        ],
      ),
    );
  }
}
