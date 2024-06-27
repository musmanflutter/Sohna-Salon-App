import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'package:sohna_salon_app/models/service_class.dart';
import 'package:transparent_image/transparent_image.dart';

class ServicesScreenAvailable extends StatelessWidget {
  const ServicesScreenAvailable(
      {super.key, required this.serviceItems, required this.changeIndex});
  final List<ServiceClass> serviceItems;
  final Function(int) changeIndex;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return serviceItems.isEmpty
        ? SizedBox(
            height:
                (screenSize.height - MediaQuery.of(context).padding.top) * 0.9,
            child: Center(
              child: Text(
                'No Services added  yet',
                style: Theme.of(context).textTheme.titleLarge!,
              ),
            ),
          )
        : Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: serviceItems.length,
                  itemBuilder: (context, index) => Card(
                    margin: EdgeInsets.only(
                      bottom: (screenSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.02,
                      top: (screenSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.01,
                      left: screenSize.width * 0.01,
                      right: screenSize.width * 0.01,
                    ),
                    color: const Color.fromARGB(255, 255, 239, 238),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        side: BorderSide(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.3))),
                    elevation: 2,
                    child: Column(
                      children: [
                        Container(
                          padding:
                              EdgeInsets.only(top: screenSize.width * 0.02),
                          height: screenSize.height * 0.3,
                          child: FadeInImage(
                            fit: BoxFit.cover,
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
                          // child: CachedNetworkImage(
                          //   cacheManager: CacheManager(Config(
                          //     'customCacheKey',
                          //     stalePeriod: const Duration(days: 7),
                          //   )),
                          //   imageUrl: serviceItems[index].serviceImage,
                          //   fit: BoxFit.cover,
                          //   placeholder: (context, url) => const Center(
                          //     child: CircularProgressIndicator(),
                          //   ),
                          //   errorWidget: (context, url, error) =>
                          //       const Icon(Icons.error),
                          // ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                serviceItems[index].serviceTitle,
                                maxLines: 1,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                              ),
                              SizedBox(
                                height: (screenSize.height -
                                        MediaQuery.of(context).padding.top) *
                                    0.007,
                              ),
                              Text(
                                serviceItems[index].serviceDescription,
                                style: Theme.of(context).textTheme.titleMedium,
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                height: (screenSize.height -
                                        MediaQuery.of(context).padding.top) *
                                    0.007,
                              ),
                              Text(
                                "Starting from: ${serviceItems[index].servicePrice} Rs",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: (screenSize.height -
                                  MediaQuery.of(context).padding.top) *
                              0.06,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(15),
                                ),
                              ),
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              foregroundColor:
                                  Theme.of(context).colorScheme.onPrimary,
                            ),
                            onPressed: () {
                              changeIndex(3);
                            },
                            child: const Text('BOOK NOW'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height:
                    (screenSize.height - MediaQuery.of(context).padding.top) *
                        0.09,
              ),
            ],
          );
  }
}
