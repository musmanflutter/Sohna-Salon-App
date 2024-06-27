import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sohna_salon_app/models/feedback_class.dart';
import 'package:timeago/timeago.dart' as timeago;

class RatingScreenAvailable extends StatelessWidget {
  const RatingScreenAvailable({super.key, required this.feedbackItems});
  final List<FeedbackClass> feedbackItems;

  double calculateAverageRating(List<FeedbackClass> feedbackItems) {
    double totalRating = 0.0;
    for (var feedback in feedbackItems) {
      totalRating += feedback.userRating;
    }
    return feedbackItems.isNotEmpty ? totalRating / feedbackItems.length : 0.0;
  }

  double calculatePercentageForRating(int ratingLevel) {
    final ratingCount = feedbackItems
        .where((feedback) => feedback.userRating == ratingLevel)
        .length;
    final totalFeedbackCount = feedbackItems.length;
    return totalFeedbackCount != 0 ? ratingCount / totalFeedbackCount : 0.0;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final averageRating = calculateAverageRating(feedbackItems);
    return feedbackItems.isEmpty
        ? SizedBox(
            height:
                (screenSize.height - MediaQuery.of(context).padding.top) * 0.9,
            child: Center(
              child: Text(
                'No Reviews added  yet',
                style: Theme.of(context).textTheme.titleLarge!,
              ),
            ),
          )
        : Column(
            children: [
              Card(
                margin: EdgeInsets.only(
                  bottom:
                      (screenSize.height - MediaQuery.of(context).padding.top) *
                          0.02,
                  top:
                      (screenSize.height - MediaQuery.of(context).padding.top) *
                          0.01,
                  left: screenSize.width * 0.01,
                  right: screenSize.width * 0.01,
                ),
                color: const Color.fromARGB(255, 255, 239, 238),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  side: BorderSide(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  ),
                ),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            averageRating.toStringAsFixed(1),
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
                                  fontSize: screenSize.width * 0.2,
                                ),
                          ),
                          RatingBarIndicator(
                            itemCount: 5,
                            itemSize: 20,
                            itemPadding: EdgeInsets.only(
                              right: screenSize.width * 0.01,
                            ),
                            rating: averageRating,
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          Text(
                            '(${(feedbackItems.length).toString()})',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer
                                        .withOpacity(0.7)),
                          )
                        ],
                      ),
                      SizedBox(
                        width: screenSize.width * 0.05,
                      ),
                      Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                          5,
                          (index) {
                            final ratingLevel = 5 - index;
                            final percentage =
                                calculatePercentageForRating(ratingLevel);
                            return Row(
                              children: [
                                Text(
                                  ratingLevel.toString(),
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(
                                      left: screenSize.width * 0.03),
                                  width: screenSize.width *
                                      0.41, // Adjust the width of the bars as needed
                                  height: 20, // Set the height of the bars
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: FractionallySizedBox(
                                    widthFactor: percentage,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: feedbackItems.length,
                  itemBuilder: (context, index) {
                    // Format the userTime into a readable string

                    final timeeAgo =
                        timeago.format(feedbackItems[index].userTime.toDate());
                    return Card(
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
                              .withOpacity(0.3),
                        ),
                      ),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
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
                                  child: CachedNetworkImage(
                                    cacheManager: CacheManager(
                                      Config(
                                        'customCacheKey',
                                        stalePeriod: const Duration(days: 7),
                                      ),
                                    ),
                                    imageUrl: feedbackItems[index].userImage,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
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
                            Text(feedbackItems[index].userFeedback)
                          ],
                        ),
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
