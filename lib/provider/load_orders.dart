import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sohna_salon_app/models/order_class.dart';

final orderProvider = StreamProvider<List<OrderClass>>((ref) {
  final userId = FirebaseAuth.instance.currentUser!.uid;
  try {
    return FirebaseFirestore.instance
        .collection('Orders')
        .where('userId', isEqualTo: userId) // Filter orders by userId
        .where('total', isGreaterThan: 0)
        .orderBy('createAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              List<String> services =
                  []; // Initialize an empty list for services
              List<String> servicesPrice = [];
              if (doc['services'] != null) {
                // Check if services field is not null
                services =
                    List<String>.from(doc['services']); // Parse services array
                servicesPrice = List<String>.from(doc['servicesPrice']);
              }

              List<String> deals = []; // Initialize an empty list for services
              List<String> dealsPrice = [];
              if (doc['deals'] != null) {
                // Check if services field is not null
                deals = List<String>.from(doc['deals']); // Parse services array
                dealsPrice = List<String>.from(doc['dealsPrice']);
              }

              return OrderClass(
                  userName: doc['name'],
                  userImage: doc['photo'],
                  date: doc['date'],
                  time: doc['time'],
                  deals: deals,
                  dealsPrice: dealsPrice,
                  services: services,
                  servicePrice: servicesPrice,
                  total: doc['total'],
                  id: doc.id);
            }).toList());
  } catch (error) {
    // Handle error

    throw Error();
  }
});


// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:sohna_salon_app/models/order_class.dart';

// final orderProvider = FutureProvider<List<OrderClass>>((ref) async {
//   final userId = FirebaseAuth.instance.currentUser!.uid;
//   try {
//     final orderData = await FirebaseFirestore.instance
//         .collection('Orders')
//         .where('userId', isEqualTo: userId) // Filter orders by userId
//         .where('total', isGreaterThan: 0)
//         .orderBy('createAt', descending: true)
//         .get();

//     if (orderData.docs.isEmpty) {
//       return [];
//     }

//     final List<OrderClass> loadedItems = [];

//     for (var item in orderData.docs) {
//       List<String> services = []; // Initialize an empty list for services
//       List<String> servicesPrice = [];
//       if (item['services'] != null) {
//         // Check if services field is not null
//         services = List<String>.from(item['services']); // Parse services array
//         servicesPrice = List<String>.from(item['servicesPrice']);
//       }

//       List<String> deals = []; // Initialize an empty list for services
//       List<String> dealsPrice = [];
//       if (item['deals'] != null) {
//         // Check if services field is not null
//         deals = List<String>.from(item['deals']); // Parse services array
//         dealsPrice = List<String>.from(item['dealsPrice']);
//       }

//       loadedItems.add(OrderClass(
//           userName: item['name'],
//           userImage: item['photo'],
//           date: item['date'],
//           time: item['time'],
//           deals: deals,
//           dealsPrice: dealsPrice,
//           services: services,
//           servicePrice: servicesPrice,
//           total: item['total'],
//           id: item.id));
//     }
//     return loadedItems;
//   } catch (error) {
//     // Handle error
//     print('message is: ${error}');
//     throw Error();
//   }
// });

// // final dealsProvider = StreamProvider<List<DealClass>>((ref) {
// //   try {
// //     return FirebaseFirestore.instance
// //         .collection('Deals')
// //         .orderBy('createAt', descending: true)
// //         .snapshots()
// //         .map((snapshot) => snapshot.docs.map((doc) {
// //               return DealClass(
// //                 dealImage: doc['imageUrl'],
// //                 dealTitle: doc['title'],
// //                 dealDescription: doc['description'],
// //                 id: doc.id,
// //                 dealPrice: doc['price'],
// //               );
// //             }).toList());
// //   } catch (error) {
// //     // Handle error
// //     throw Error();
// //   }
// // });
