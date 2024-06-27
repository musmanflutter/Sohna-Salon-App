import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sohna_salon_app/models/deal_class.dart';

// final dealsProvider = FutureProvider<List<DealClass>>((ref) async {
//   try {
//     final dealData = await FirebaseFirestore.instance
//         .collection('Deals')
//         .orderBy('createAt', descending: true)
//         .get();

//     if (dealData.docs.isEmpty) {
//       return [];
//     }

//     final List<DealClass> loadedItems = [];
//     for (var item in dealData.docs) {
//       loadedItems.add(
//         DealClass(
//           dealImage: item['imageUrl'],
//           dealTitle: item['title'],
//           dealDescription: item['description'],
//           id: item.id,
//           dealPrice: item['price'],
//         ),
//       );
//     }
//     return loadedItems;
//   } catch (error) {
//     // Handle error
//     throw Error();
//   }
// });

final dealsProvider = StreamProvider<List<DealClass>>((ref) {
  try {
    return FirebaseFirestore.instance
        .collection('Deals')
        .orderBy('createAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              return DealClass(
                dealImage: doc['imageUrl'],
                dealTitle: doc['title'],
                dealDescription: doc['description'],
                id: doc.id,
                dealPrice: doc['price'],
              );
            }).toList());
  } catch (error) {
    // Handle error
    throw Error();
  }
});
