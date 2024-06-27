import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sohna_salon_app/models/deal_class.dart';
import 'package:sohna_salon_app/models/service_class.dart';
import 'package:sohna_salon_app/provider/selected_index.dart';

import 'package:sohna_salon_app/widgets/booking/steps/step_three.dart';
import 'package:sohna_salon_app/widgets/booking/steps/step_two.dart';
import 'package:sohna_salon_app/widgets/booking/steps/step_four.dart';
import 'package:sohna_salon_app/widgets/booking/custom_buttons.dart';
import 'package:sohna_salon_app/widgets/booking/steps/step_one.dart';

class BookingScreen extends ConsumerStatefulWidget {
  const BookingScreen({super.key});

  @override
  ConsumerState<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends ConsumerState<BookingScreen> {
  final user = FirebaseAuth.instance.currentUser;
  int _currentStep = 0;
  double _totalPrice = 0.0;
  DateTime _selectedDate = DateTime.now();
  String _selectedTime = '';
  List<String> servicesName = [];
  List<String> servicesPrice = [];
  List<String> dealsNames = [];
  List<String> dealsPrice = [];
  List<String> serviceFallbackText = [
    'No Services added',
  ];
  List<String> servicePriceFallbackText = [
    '',
  ];
  List<String> dealsFallbackText = [
    'No Deals added',
  ];
  List<ServiceClass> _selectedServices = [];
  List<DealClass> _selectedDeals = [];
  var isAuthenticating = false;
  var userName = FirebaseAuth.instance.currentUser!.displayName;
  var userPhoto = FirebaseAuth.instance.currentUser!.photoURL;
  String photoUrl =
      'https://yaktribe.games/community/media/placeholder-jpg.84782/full';
  String? oUserName;

  @override
  void initState() {
    super.initState();
    fetchUserData(); // Call fetchUserData method when the widget initializes
  }

  Future<void> fetchUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final localName = prefs.getString('name');
    // print('local name is $localName');
    if (localName != null) {
      setState(() {
        userName = localName;
      });
    } else {
      final userData = await FirebaseFirestore.instance
          .collection('SignUp Users')
          .doc(user!.uid)
          .get();
      setState(() {
        oUserName = userData.data()!['name'];
        photoUrl = userData.data()!['photoUrl'];
      });
    }
  }

  void submitBooking(Size screenSize) async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      // No available network types
      if (!mounted) return;
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'No internet connection. Please check your connection and try again.'),
        ),
      );
      return;
    }
    try {
      setState(() {
        isAuthenticating = true;
      });
      List<String> selectedServiceNames = getSelectedServiceNames();
      List<String> selectedServicePrice = getSelectedServicePrice();
      List<String> selectedDealsNames = getSelectedDealsNames();
      List<String> selectedDealsPrice = getSelectedDealsPrice();

      // Print statements for debugging
      // print("Booking Name: ${userName ?? oUserName}");
      // print("Booking Photo URL: ${userPhoto ?? photoUrl}");

      final bookingCollection = FirebaseFirestore.instance.collection('Orders');

      await bookingCollection.add({
        'createAt': Timestamp.now(),
        'userId': user!.uid,
        'name': userName ?? oUserName,
        'photo': userPhoto ?? photoUrl,
        'date': _selectedDate,
        'time': _selectedTime,
        'services': selectedServiceNames.isNotEmpty
            ? selectedServiceNames
            : serviceFallbackText,
        'servicesPrice': selectedServicePrice.isNotEmpty
            ? selectedServicePrice
            : servicePriceFallbackText,
        'deals': selectedDealsNames.isNotEmpty
            ? selectedDealsNames
            : dealsFallbackText,
        'dealsPrice': selectedDealsPrice.isNotEmpty
            ? selectedDealsPrice
            : servicePriceFallbackText,
        'total': _totalPrice
      });
      // final storageRef = FirebaseStorage.instance
      //     .ref()
      //     .child('review_images')
      //     .child('${doc.id}.jpg');
      //     await storageRef.putFile(userPhoto);
      // final feedbackData = {
      //   'rating': rating,
      //   'feedback': feedback,
      //   'createAt': Timestamp.now(),
      //   'name': 'usman',
      //   'profilePicUrl': 'assets/images/logo.png',
      // };
      // await FirebaseFirestore.instance.collection('Feedback').add(feedbackData);
      // Reset the fields after submission
      final formattedDate = DateFormat('EEE, dd/MM/y').format(_selectedDate);
      setState(() {
        isAuthenticating = false;
      });
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            contentPadding: const EdgeInsets.all(10),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle,
                  size: screenSize.height * 0.1,
                  color: Colors.green, // Change color according to your theme
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: screenSize.height * 0.01,
                  ),
                  child: Text(
                    'Your booking has been placed!',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                Text(
                  'Thank you for booking our services! Your appointment is confirmed for $formattedDate at $_selectedTime. You can review your bookings in the app\'s menu. We look forward to serving you!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: screenSize.height * 0.01),
                SizedBox(
                  width: screenSize.width * 0.5,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {
                      changeIndex(0);
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'OK',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );

      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     content: Text('Order booked successfully!'),
      //   ),
      // );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Failed to book order. Please try again later. error: $error'),
        ),
      );
    }
  }

//   Future<void> _saveDialogToGallery(BuildContext context) async {
//   try {
//     // Capture the content of the dialog box as an image
//     RenderRepaintBoundary boundary =
//         context.findRenderObject() as RenderRepaintBoundary;
//     ui.Image image = await boundary.toImage(pixelRatio: 3.0);
//     ByteData? byteData =
//         await image.toByteData(format: ui.ImageByteFormat.png);
//     Uint8List pngBytes = byteData!.buffer.asUint8List();

//     // Save the image to the device's gallery
//     final result = await ImageGallerySaver.saveImage(pngBytes);
//     print('Image saved to gallery: $result');

//     Navigator.of(context).pop(); // Close the dialog box
//   } catch (error) {
//     print('Failed to save image: $error');
//   }
// }

  void changeIndex(int num) {
    ref.read(indexProvider.notifier).updateIndex(num);
  }

  void updateTotalPrice(double price) {
    setState(() {
      _totalPrice += price;
    });
  }

  void updateSelectedServices(List<ServiceClass> selectedServices) {
    setState(() {
      _selectedServices = selectedServices;
    });
  }

  List<String> getSelectedServiceNames() {
    for (ServiceClass service in _selectedServices) {
      servicesName.add(service.serviceTitle);
    }
    return servicesName;
  }

  List<String> getSelectedServicePrice() {
    for (ServiceClass service in _selectedServices) {
      servicesPrice.add('${service.servicePrice} Rs');
    }
    return servicesPrice;
  }

  void updateSelectedDeals(List<DealClass> selectedDeals) {
    setState(() {
      _selectedDeals = selectedDeals;
    });
  }

  List<String> getSelectedDealsNames() {
    for (DealClass deal in _selectedDeals) {
      dealsNames.add(deal.dealTitle);
    }
    return dealsNames;
  }

  List<String> getSelectedDealsPrice() {
    for (DealClass deal in _selectedDeals) {
      dealsPrice.add('${deal.dealPrice} Rs');
    }
    return dealsPrice;
  }

  void selectDate(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  void selectTime(String time) {
    setState(() {
      _selectedTime = time;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SizedBox(
      height: screenSize.height,
      child: Stepper(
        physics: const BouncingScrollPhysics(),
        currentStep: _currentStep,
        onStepTapped: (step) {
          _currentStep == 0 && _selectedTime.isEmpty
              ? () {}
              : _currentStep == 2 && _totalPrice == 0
                  ? () {}
                  : setState(() {
                      _currentStep = step;
                    });
        },
        onStepContinue: () {
          if (_currentStep == 3) {
            submitBooking(screenSize);
          } else {
            setState(() {
              _currentStep += 1;
            });
          }
        },
        onStepCancel: () {
          setState(() {
            _currentStep -= 1;
          });
        },
        controlsBuilder: (context, details) {
          return CustomButtons(
              isAuthenticating: isAuthenticating,
              currentStep: _currentStep,
              totalPrice: _totalPrice,
              selectedTime: _selectedTime,
              details: details);
        },
        steps: [
          Step(
            state: _currentStep > 0 ? StepState.complete : StepState.indexed,
            isActive: _currentStep >= 0,
            title: const Text('Date & Time'),
            content: StepOne(selectDate: selectDate, selectTime: selectTime),
          ),
          Step(
            state: _currentStep > 1 ? StepState.complete : StepState.indexed,
            isActive: _currentStep >= 1,
            title: const Text('Services'),
            content: StepTwo(
                updateTotalPrice: updateTotalPrice,
                updateSelectedServices: updateSelectedServices,
                totalPrice: _totalPrice),
          ),
          Step(
            state: _currentStep > 2 ? StepState.complete : StepState.indexed,
            isActive: _currentStep >= 2,
            title: const Text('Deals '),
            content: StepThree(
              updateTotalPrice: updateTotalPrice,
              updateSelectedDeals: updateSelectedDeals,
              totalPrice: _totalPrice,
            ),
          ),
          Step(
            state: _currentStep > 3 ? StepState.complete : StepState.indexed,
            isActive: _currentStep >= 3,
            title: const Text('Confirm'),
            content: StepFour(
              date: _selectedDate,
              time: _selectedTime,
              services: _selectedServices,
              deals: _selectedDeals,
              total: _totalPrice,
            ),
          )
        ],
      ),
    );
  }
}
