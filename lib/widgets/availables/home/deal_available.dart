import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'package:sohna_salon_app/models/deal_class.dart';
import 'package:sohna_salon_app/widgets/home/title_row.dart';
import 'package:transparent_image/transparent_image.dart';

class DealAvailable extends StatelessWidget {
  const DealAvailable(
      {super.key, required this.dealItems, required this.changeIndex});
  final List<DealClass> dealItems;
  final Function(int) changeIndex;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        TitleRow(text: 'Best Deals', changeIndex: changeIndex, index: 2),
        SizedBox(
          height:
              (screenSize.height - MediaQuery.of(context).padding.top) * 0.004,
        ),
        dealItems.isEmpty
            ? SizedBox(
                height:
                    (screenSize.height - MediaQuery.of(context).padding.top) *
                        0.3,
                child: Center(
                  child: Text(
                    'No Deals added  yet',
                    style: Theme.of(context).textTheme.titleLarge!,
                  ),
                ),
              )
            : CarouselSlider(
                items: dealItems.map((deal) {
                  return
                      // Container(
                      //   margin: EdgeInsets.symmetric(
                      //       horizontal: screenSize.width * 0.01),
                      //   width: screenSize.width * 0.8,

                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(15),
                      //     color: Theme.of(context).colorScheme.primary,
                      //   ),
                      //   clipBehavior: Clip.hardEdge,
                      //   child: FadeInImage(
                      //     fit: BoxFit.cover,
                      //     placeholder:
                      //         // Placeholder image
                      //         MemoryImage(kTransparentImage),
                      //     image: CachedNetworkImageProvider(
                      //       deal.dealImage,
                      //       cacheManager: CacheManager(Config(
                      //         'customCacheKey',
                      //         stalePeriod: const Duration(days: 7),
                      //       )),
                      //     ),

                      //     fadeInDuration: const Duration(milliseconds: 300),
                      //     fadeOutDuration: const Duration(milliseconds: 100),
                      //     // Optional parameters for customizing the fade-in effect
                      //     fadeOutCurve: Curves.easeOut,
                      //     fadeInCurve: Curves.easeIn,
                      //   ),
                      // color: Theme.of(context).colorScheme.primary,
                      SizedBox(
                    width: screenSize.width * 0.8,
                    child: Card(
                      // color: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      clipBehavior: Clip.hardEdge,
                      elevation: 2,
                      child: FadeInImage(
                        fit: BoxFit.cover,
                        placeholder:
                            // Placeholder image
                            MemoryImage(kTransparentImage),
                        image: CachedNetworkImageProvider(
                          deal.dealImage,
                          cacheManager: CacheManager(Config(
                            'customCacheKey',
                            stalePeriod: const Duration(days: 7),
                          )),
                        ),

                        fadeInDuration: const Duration(milliseconds: 300),
                        fadeOutDuration: const Duration(milliseconds: 100),
                        // Optional parameters for customizing the fade-in effect
                        fadeOutCurve: Curves.easeOut,
                        fadeInCurve: Curves.easeIn,
                      ),
                      //   // CachedNetworkImage(
                      //   //   imageUrl: deal.dealImage,
                      //   //   fit: BoxFit.cover,
                      //   //   cacheManager: CacheManager(Config(
                      //   //     'customCacheKey',
                      //   //     stalePeriod: const Duration(days: 7),
                      //   //   )),
                      //   //   placeholder: (context, url) => const Center(
                      //   //     child: CircularProgressIndicator(),
                      //   //   ),
                      //   //   errorWidget: (context, url, error) => const Icon(Icons.error),
                      //   // ),
                      // ),
                    ),
                  );
                }).toList(),
                options: CarouselOptions(
                  // aspectRatio: 16 / 9,
                  autoPlay: true,
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayInterval: const Duration(seconds: 2),
                  onPageChanged: (index, reason) {},
                ),
              ),
      ],
    );
  }
}
