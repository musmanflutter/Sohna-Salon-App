import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sohna_salon_app/models/service_class.dart';

// final serviceProvider = FutureProvider<List<ServiceClass>>((ref) async {
//   try {
//     final serviceData = await FirebaseFirestore.instance
//         .collection('Services')
//         .orderBy('createAt', descending: true)
//         .get();

//     if (serviceData.docs.isEmpty) {
//       return [];
//     }

//     final List<ServiceClass> loadedItems = [];
//     for (var item in serviceData.docs) {
//       loadedItems.add(
//         ServiceClass(
//           serviceImage: item['imageUrl'],
//           serviceTitle: item['title'],
//           serviceDescription: item['description'],
//           id: item.id,
//           servicePrice: item['price'],
//         ),
//       );
//     }
//     return loadedItems;
//   } catch (error) {
//     // Handle error
//     throw Error();
//   }
// });

final serviceProvider = StreamProvider<List<ServiceClass>>((ref) {
  try {
    return FirebaseFirestore.instance
        .collection('Services')
        .orderBy('createAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              return ServiceClass(
                serviceImage: doc['imageUrl'],
                serviceTitle: doc['title'],
                serviceDescription: doc['description'],
                id: doc.id,
                servicePrice: doc['price'],
              );
            }).toList());
  } catch (error) {
    // Handle error gracefully
    // print('Error fetching data: $error');
    return Stream.value(
        <ServiceClass>[]); // Return an empty stream in case of error
  }
});
