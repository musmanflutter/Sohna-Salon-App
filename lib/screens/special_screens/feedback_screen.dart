import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final user = FirebaseAuth.instance.currentUser;
  String feedbackGot = '';
  double ratingGot = 4.0;
  String photoUrl =
      'https://th.bing.com/th/id/OIP.EBfmCfQLZDdCPu24HE5WRAHaHa?rs=1&pid=ImgDetMain';
  String? oUserName;
  var isAuthenticating = false;
  final formKey = GlobalKey<FormState>();
  var userName = FirebaseAuth.instance.currentUser!.displayName;
  var userPhoto = FirebaseAuth.instance.currentUser!.photoURL;
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
      oUserName = userData.data()!['name'];
      photoUrl = userData.data()!['photoUrl'];
    }
  }

  void submitFeedback(Size screenSize) async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      // No available network
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
    final isValid = formKey.currentState!.validate();

    if (!isValid) {
      return;
    }
    formKey.currentState!.save();
    try {
      setState(() {
        isAuthenticating = true;
      });
      final feedbackCollection =
          FirebaseFirestore.instance.collection('Feedback');

      await feedbackCollection.add({
        'createAt': Timestamp.now(),
        'name': userName ?? oUserName,
        'description': feedbackGot,
        'rating': ratingGot,
        'photo': userPhoto ?? photoUrl,
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
      setState(() {
        ratingGot = 0.0;
        feedbackGot = '';
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
                    'Feedback submitted succesfully!',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
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
                      Navigator.of(context).pop();
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
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Failed to submit feedback. Please try again later. error: $error'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    // final profilePic = FirebaseAuth.instance.currentUser!.photoURL;
    final appBar = AppBar(
      toolbarHeight:
          (screenSize.height - MediaQuery.of(context).padding.top) * 0.1,
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      centerTitle: true,
      title: const Text('Feedback'),
    );
    return Scaffold(
      appBar: appBar,
      body: Stack(
        children: [
          Container(
            color: Theme.of(context).colorScheme.primary,
          ),
          Container(
            width: screenSize.width,
            height: screenSize.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top,
            padding: EdgeInsets.only(
              top: screenSize.height * 0.02,
              right: screenSize.width * 0.03,
              left: screenSize.width * 0.03,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background.withOpacity(0.95),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(25),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rating',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: screenSize.width * 0.015,
                      vertical: (screenSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.01,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'How was your experience with our salon?',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                fontWeight: FontWeight.bold,
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                        ),
                        SizedBox(
                          height: (screenSize.height -
                                  MediaQuery.of(context).padding.top) *
                              0.007,
                        ),
                        RatingBar.builder(
                          itemSize: 35,
                          initialRating: 4,
                          minRating: 1,
                          allowHalfRating: true,
                          itemCount: 5,
                          glow: false,
                          itemPadding: EdgeInsets.only(
                            right: screenSize.width * 0.01,
                          ),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          onRatingUpdate: (rating) {
                            ratingGot = rating;
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: (screenSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.02,
                  ),
                  Text(
                    'Comment',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: screenSize.width * 0.015,
                      vertical: (screenSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.01,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Share your thoughts:',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                fontWeight: FontWeight.bold,
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                        ),
                        SizedBox(
                          height: (screenSize.height -
                                  MediaQuery.of(context).padding.top) *
                              0.007,
                        ),
                        Form(
                          key: formKey,
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'This field can\'t be empty.';
                              }

                              return null;
                            },
                            onChanged: (value) {
                              feedbackGot = value;
                            },
                            maxLines: 8,
                            maxLength: 300,
                            decoration: InputDecoration(
                              hintText: 'Write your feedback here...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: (screenSize.height -
                                  MediaQuery.of(context).padding.top) *
                              0.02,
                        ),
                        isAuthenticating
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    backgroundColor:
                                        Theme.of(context).colorScheme.primary,
                                    foregroundColor:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                                  onPressed: () {
                                    submitFeedback(screenSize);
                                  },
                                  child: Text(
                                    'Submit',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
