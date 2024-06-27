import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'package:sohna_salon_app/models/service_class.dart';
import 'package:sohna_salon_app/widgets/home/title_row.dart';

class ServiceAvailable extends StatelessWidget {
  const ServiceAvailable(
      {super.key, required this.serviceItems, required this.changeIndex});
  final List<ServiceClass> serviceItems;
  final Function(int) changeIndex;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        TitleRow(text: 'Top Services', changeIndex: changeIndex, index: 1),
        serviceItems.isEmpty
            ? SizedBox(
                height:
                    (screenSize.height - MediaQuery.of(context).padding.top) *
                        0.142,
                child: Center(
                  child: Text(
                    'No Services added  yet',
                    style: Theme.of(context).textTheme.titleLarge!,
                  ),
                ),
              )
            : SizedBox(
                height:
                    (screenSize.height - MediaQuery.of(context).padding.top) *
                        0.142,
                child: ListView.builder(
                  itemCount: serviceItems.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          height: (screenSize.height -
                                  MediaQuery.of(context).padding.top) *
                              0.11,
                          width: (screenSize.height -
                                  MediaQuery.of(context).padding.top) *
                              0.11,
                          padding: EdgeInsets.all(screenSize.width * 0.01),
                          margin: EdgeInsets.symmetric(
                            horizontal: screenSize.width * 0.015,
                            vertical: (screenSize.height -
                                    MediaQuery.of(context).padding.top) *
                                0.005,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.3),
                            ),
                            borderRadius: BorderRadius.circular(15),
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                          ),
                          child: FadeInImage(
                            placeholder:
                                // Placeholder image
                                MemoryImage(kTransparentImage),
                            image: CachedNetworkImageProvider(
                              serviceItems[index].serviceImage,
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
                          //   imageUrl: serviceItems[index].serviceImage,
                          //   fit: BoxFit.cover,
                          //   cacheManager: CacheManager(Config(
                          //     'customCacheKey',
                          //     stalePeriod: const Duration(days: 7),
                          //   )),
                          //   placeholder: (context, url) => const Center(
                          //     child: FadeInImage(placeholder: MemoryImage(), image: image),
                          //   ),
                          //   errorWidget: (context, url, error) =>
                          //       const Icon(Icons.error),
                          // ),
                        ),
                        Text(
                          serviceItems[index].serviceTitle,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ],
                    );
                  },
                ),
              )
      ],
    );
  }
}
