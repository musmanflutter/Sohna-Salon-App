import 'package:cloud_firestore/cloud_firestore.dart';

class OrderClass {
  final String userImage;
  final String userName;
  final Timestamp date;
  final String time;
  final List<String> services;
  final List<String> servicePrice;
  final List<String> deals;
  final List<String> dealsPrice;
  final double total;
  final String id;

  OrderClass({
    required this.userName,
    required this.userImage,
    required this.date,
    required this.time,
    required this.deals,
    required this.dealsPrice,
    required this.services,
    required this.servicePrice,
    required this.total,
    required this.id,
  });
}
