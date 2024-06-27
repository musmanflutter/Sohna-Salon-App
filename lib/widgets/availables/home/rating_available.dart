import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sohna_salon_app/models/feedback_class.dart';
import 'package:sohna_salon_app/screens/base/special_screen.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:transparent_image/transparent_image.dart';

class RatingAvailable extends StatelessWidget {
  const RatingAvailable(
      {super.key, required this.feedbackItems, required this.changeIndex});
  final List<FeedbackClass> feedbackItems;
  final Function(int) changeIndex;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rating and Reviews',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const Spacer(),
            TextButton(
              style: TextButton.styleFrom(
                alignment: Alignment.topRight,
                padding: EdgeInsets.only(left: screenSize.width * 0.04),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const SpecialScreen(),
                ));
                changeIndex(1);
              },
              child: Text(
                'View all',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),
          ],
        ),
        SizedBox(
          height:
              (screenSize.height - MediaQuery.of(context).padding.top) * 0.01,
        ),
        feedbackItems.isEmpty
            ? SizedBox(
                height:
                    (screenSize.height - MediaQuery.of(context).padding.top) *
                        0.36,
                child: Center(
                  child: Text(
                    'No Reviews added  yet',
                    style: Theme.of(context).textTheme.titleLarge!,
                  ),
                ),
              )
            : SizedBox(
                height:
                    (screenSize.height - MediaQuery.of(context).padding.top) *
                        0.36,
                child: ListView.builder(
                  itemCount: feedbackItems.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    // Format the userTime into a readable string
                    final timeeAgo =
                        timeago.format(feedbackItems[index].userTime.toDate());
                    return Container(
                      width: screenSize.width * 0.8,
                      padding: const EdgeInsets.all(12),
                      margin: EdgeInsets.symmetric(
                        horizontal: screenSize.width * 0.015,
                        vertical: (screenSize.height -
                                MediaQuery.of(context).padding.top) *
                            0.005,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primaryContainer
                            .withOpacity(0.7),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.3),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                clipBehavior: Clip.hardEdge,
                                height: screenSize.height * 0.08,
                                width: screenSize.height * 0.08,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    60,
                                  ),
                                ),
                                child: FadeInImage(
                                  fit: BoxFit.cover,
                                  placeholder:
                                      // Placeholder image
                                      MemoryImage(kTransparentImage),
                                  image: CachedNetworkImageProvider(
                                    feedbackItems[index].userImage,
                                    cacheManager: CacheManager(Config(
                                      'customCacheKey',
                                      stalePeriod: const Duration(days: 7),
                                    )),
                                  ),

                                  fadeInDuration:
                                      const Duration(milliseconds: 300),
                                  fadeOutDuration:
                                      const Duration(milliseconds: 100),
                                  // Optional parameters for customizing the fade-in effect
                                  fadeOutCurve: Curves.easeOut,
                                  fadeInCurve: Curves.easeIn,
                                ),
                                // child: CachedNetworkImage(
                                //   cacheManager: CacheManager(
                                //     Config(
                                //       'customCacheKey',
                                //       stalePeriod: const Duration(days: 7),
                                //     ),
                                //   ),
                                //   imageUrl: feedbackItems[index].userImage,
                                //   fit: BoxFit.cover,
                                //   placeholder: (context, url) =>
                                //       const CircularProgressIndicator(),
                                //   errorWidget: (context, url, error) =>
                                //       const Icon(Icons.error),
                                // ),
                              ),
                              SizedBox(
                                width: screenSize.width * 0.05,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    feedbackItems[index].userName,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimaryContainer,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  Text(
                                    timeeAgo,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimaryContainer
                                                .withOpacity(0.6)),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: screenSize.height * 0.01,
                          ),
                          RatingBarIndicator(
                            itemCount: 5,
                            itemSize: 20,
                            itemPadding: EdgeInsets.only(
                              right: screenSize.width * 0.01,
                            ),
                            rating: feedbackItems[index].userRating,
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          SizedBox(
                            height: screenSize.height * 0.01,
                          ),
                          Expanded(
                            child: Text(feedbackItems[index].userFeedback),
                          )
                        ],
                      ),
                    );
                    // ListTile(
                    //   leading: CircleAvatar(
                    //     // radius: 50,
                    //     backgroundImage: AssetImage(imageLink[index]),
                    //   ),
                    //   title: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Text('Usman'),
                    //       Text(
                    //         '14-08-24',
                    //         style: TextStyle(color: Colors.grey),
                    //       ),
                    //     ],
                    //   ),
                    //   subtitle: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       RatingBar.builder(
                    //         initialRating: 4,
                    //         minRating: 1,
                    //         direction: Axis.horizontal,
                    //         allowHalfRating: true,
                    //         itemCount: 5,
                    //         itemSize: 20,
                    //         itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                    //         itemBuilder: (context, _) => Icon(
                    //           Icons.star,
                    //           color: Colors.amber,
                    //         ),
                    //         onRatingUpdate: (rating) {
                    //           // You can handle rating update if needed
                    //         },
                    //       ),
                    //       SizedBox(height: 4),
                    //       Text(
                    //           "Great experience! Highly recommend this app. The service was excellent, and the staff was very friendly and professional. Will definitely use it again!"),
                    //     ],
                    //   ),
                    // );
                  },
                ),
              ),
      ],
    );
  }
}
