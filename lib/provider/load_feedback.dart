import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sohna_salon_app/models/feedback_class.dart';

final feedbackProvider = StreamProvider<List<FeedbackClass>>((ref) {
  try {
    return FirebaseFirestore.instance
        .collection('Feedback')
        .orderBy('createAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((item) {
              return FeedbackClass(
                userImage: item['photo'],
                userName: item['name'],
                userFeedback: item['description'],
                userRating: item['rating'],
                userTime: item['createAt'],
                id: item.id,
              );
            }).toList());
  } catch (error) {
    // Handle error
    throw Error();
  }
});

// final feedbackProvider = FutureProvider<List<FeedbackClass>>((ref) async {
//   try {
//     final feedbackData = await FirebaseFirestore.instance
//         .collection('Feedback')
//         .orderBy('createAt', descending: true)
//         .get();

//     if (feedbackData.docs.isEmpty) {
//       return [];
//     }

//     final List<FeedbackClass> loadedItems = [];
//     for (var item in feedbackData.docs) {
//       loadedItems.add(
// FeedbackClass(
//   userImage: item['photo'],
//   userName: item['name'],
//   userFeedback: item['description'],
//   userRating: item['rating'],
//   userTime: item['createAt'],
//   id: item.id,
// ),
//       );
//     }
//     return loadedItems;
//   } catch (error) {
//     // Handle error
//     throw Error();
//   }
// });
