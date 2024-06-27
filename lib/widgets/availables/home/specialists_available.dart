import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'package:sohna_salon_app/models/specialist_class.dart';
import 'package:sohna_salon_app/widgets/home/title_row.dart';
import 'package:transparent_image/transparent_image.dart';

class SpecialistsAvailable extends StatelessWidget {
  const SpecialistsAvailable(
      {super.key, required this.specialistItems, required this.changeIndex});
  final List<SpecialistClass> specialistItems;
  final Function(int) changeIndex;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        TitleRow(text: 'Top Specialist', changeIndex: changeIndex, index: 3),
        SizedBox(
          height:
              (screenSize.height - MediaQuery.of(context).padding.top) * 0.013,
        ),
        specialistItems.isEmpty
            ? SizedBox(
                height:
                    (screenSize.height - MediaQuery.of(context).padding.top) *
                        0.2,
                child: Center(
                  child: Text(
                    'No Specialist added  yet',
                    style: Theme.of(context).textTheme.titleLarge!,
                  ),
                ),
              )
            : SizedBox(
                height:
                    (screenSize.height - MediaQuery.of(context).padding.top) *
                        0.35,
                child: ListView.builder(
                  itemCount: specialistItems.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Stack(
                    children: [
                      Container(
                        clipBehavior: Clip.hardEdge,
                        height: (screenSize.height -
                                MediaQuery.of(context).padding.top) *
                            0.35,
                        width: screenSize.width * 0.44,
                        margin: EdgeInsets.only(
                          left: screenSize.width * 0.015,
                          right: screenSize.width * 0.015,
                          top: (screenSize.height -
                                  MediaQuery.of(context).padding.top) *
                              0.022,
                          bottom: (screenSize.height -
                                  MediaQuery.of(context).padding.top) *
                              0.01,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: FadeInImage(
                          fit: BoxFit.cover,
                          placeholder:
                              // Placeholder image
                              MemoryImage(kTransparentImage),
                          image: CachedNetworkImageProvider(
                            specialistItems[index].specialistImage,
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
                        // CachedNetworkImage(
                        //   fit: BoxFit.cover,
                        //   imageUrl: specialistItems[index].specialistImage,
                        //   cacheManager: CacheManager(Config(
                        //     'customCacheKey',
                        //     stalePeriod: const Duration(days: 7),
                        //   )),
                        //   placeholder: (context, url) => const Center(
                        //     child: CircularProgressIndicator(),
                        //   ),
                        //   errorWidget: (context, url, error) =>
                        //       const Icon(Icons.error),
                        // ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.6),
                            borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(15),
                            ),
                          ),
                          height: (screenSize.height -
                                  MediaQuery.of(context).padding.top) *
                              0.05,
                          width: screenSize.width * 0.44,
                          margin: EdgeInsets.symmetric(
                            horizontal: screenSize.width * 0.015,
                            vertical: (screenSize.height -
                                    MediaQuery.of(context).padding.top) *
                                0.01,
                          ),
                          child: Text(
                            specialistItems[index].specialistTitle,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ],
    );
  }
}
