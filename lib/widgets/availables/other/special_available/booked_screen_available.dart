import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:intl/intl.dart';

import 'package:sohna_salon_app/models/order_class.dart';

class BookedScreenAvailable extends StatelessWidget {
  const BookedScreenAvailable({
    super.key,
    required this.orderItems,
  });
  final List<OrderClass> orderItems;

  @override
  Widget build(BuildContext context) {
    Future<void> cancelBooking(String bookingId) async {
      try {
        await FirebaseFirestore.instance
            .collection('Orders')
            .doc(bookingId)
            .delete();
      } catch (error) {
        // print('Failed to cancel booking: $error');
        // Handle error appropriately here
      }
    }

    final screenSize = MediaQuery.of(context).size;
    return orderItems.isEmpty
        ? SizedBox(
            height:
                (screenSize.height - MediaQuery.of(context).padding.top) * 0.9,
            child: Center(
              child: Text(
                'No Booking yet',
                style: Theme.of(context).textTheme.titleLarge!,
              ),
            ),
          )
        : Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: orderItems.length,
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
                            .withOpacity(0.3),
                      ),
                    ),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                clipBehavior: Clip.hardEdge,
                                height: screenSize.height * 0.1,
                                width: screenSize.height * 0.1,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    60,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    60,
                                  ),
                                  child: CachedNetworkImage(
                                    cacheManager: CacheManager(
                                      Config(
                                        'customCacheKey',
                                        stalePeriod: const Duration(days: 7),
                                      ),
                                    ),
                                    imageUrl: orderItems[index].userImage,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: screenSize.width * 0.05,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    orderItems[index].userName,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  SizedBox(height: screenSize.height * 0.003),
                                  Row(
                                    children: [
                                      Text(
                                        'Selected Date: ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimaryContainer),
                                      ),
                                      Text(
                                        DateFormat('dd/MM/yyyy').format(
                                            orderItems[index].date.toDate()),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimaryContainer),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Booked Time: ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimaryContainer),
                                      ),
                                      Text(
                                        orderItems[index].time,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimaryContainer),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: screenSize.height * 0.01),
                          Text(
                            'Thank you for choosing Sohna Hair Salon! We\'re excited to serve you.',
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimaryContainer,
                                      fontSize: screenSize.width * 0.042,
                                    ),
                          ),
                          SizedBox(height: screenSize.height * 0.01),
                          Text(
                            'Selected Services:',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
                                  fontSize: screenSize.width * 0.042,
                                ),
                          ),
                          SizedBox(height: screenSize.height * 0.005),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // SizedBox(
                                //   width: screenSize.width * 0.03,
                                // ),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: orderItems[index]
                                      .services
                                      .map(
                                        (service) => Text(
                                          service,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimaryContainer,
                                                fontSize:
                                                    screenSize.width * 0.042,
                                              ),
                                        ),
                                      )
                                      .toList(),
                                ),
                                const Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: orderItems[index]
                                      .servicePrice
                                      .map(
                                        (service) => Text(
                                          service,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimaryContainer,
                                                fontSize:
                                                    screenSize.width * 0.042,
                                              ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: screenSize.height * 0.01),
                          Text(
                            'Selected Deals:',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
                                  fontSize: screenSize.width * 0.042,
                                ),
                          ),
                          SizedBox(height: screenSize.height * 0.005),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: orderItems[index]
                                      .deals
                                      .map(
                                        (deal) => Text(
                                          deal,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimaryContainer,
                                                fontSize:
                                                    screenSize.width * 0.042,
                                              ),
                                        ),
                                      )
                                      .toList(),
                                ),
                                const Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: orderItems[index]
                                      .dealsPrice
                                      .map(
                                        (deal) => Text(
                                          deal,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimaryContainer,
                                                fontSize:
                                                    screenSize.width * 0.042,
                                              ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: screenSize.height * 0.01),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 0.0),
                            child: Row(
                              children: [
                                Text(
                                  'Total: ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimaryContainer,
                                        fontSize: screenSize.width * 0.042,
                                      ),
                                ),
                                const Spacer(),
                                Text(
                                  '${orderItems[index].total.toStringAsFixed(0)} Rs',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimaryContainer,
                                        fontSize: screenSize.width * 0.042,
                                      ),
                                ),
                                // You can add more actions/buttons here if needed
                              ],
                            ),
                          ),
                          SizedBox(height: screenSize.height * 0.01),
                          Text(
                            'Note: Feel free to customize your package upon arrival at the salon. Payment can be made in-store.',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer
                                      .withOpacity(0.5),
                                  fontSize: screenSize.width * 0.042,
                                ),
                          ),
                          SizedBox(
                            height: screenSize.height * 0.01,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                foregroundColor:
                                    Theme.of(context).colorScheme.onPrimary,
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    title: Text(
                                      'Confirmation',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    content: Text(
                                      'Are you sure you want to cancel this booking?',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                    actions: [
                                      OutlinedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('No'),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          foregroundColor: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                        ),
                                        onPressed: () async {
                                          Navigator.of(context).pop();
                                          await cancelBooking(
                                              orderItems[index].id);
                                        },
                                        child: const Text('Yes'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: const Text('CANCEL'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}
