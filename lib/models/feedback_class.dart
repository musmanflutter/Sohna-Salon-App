import 'package:cloud_firestore/cloud_firestore.dart';

class FeedbackClass {
  final String userImage;
  final String userName;
  final double userRating;
  final String userFeedback;
  final Timestamp userTime;
  final String id;

  FeedbackClass({
    required this.userImage,
    required this.userName,
    required this.userRating,
    required this.userFeedback,
    required this.userTime,
    required this.id,
  });
}
