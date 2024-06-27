// widgets/drawer_header_set.dart
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sohna_salon_app/provider/load_user.dart';
import 'package:transparent_image/transparent_image.dart';

class DrawerHeaderSet extends ConsumerStatefulWidget {
  const DrawerHeaderSet({super.key});

  @override
  ConsumerState<DrawerHeaderSet> createState() => _DrawerHeaderSetState();
}

class _DrawerHeaderSetState extends ConsumerState<DrawerHeaderSet> {
  File? pickedImageFile;
  bool isUploading = false; // Add this line
  Future<void> saveProfilePictureUrl(String userId, String imageUrl) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception("User not logged in");
      }

      // Check if the user signed in with Google
      final isGoogleSignIn = user.providerData.any(
          (userInfo) => userInfo.providerId == GoogleAuthProvider.PROVIDER_ID);

      if (isGoogleSignIn) {
        // If authenticated with Google, save the photo in 'Google Users' collection
        final userRef =
            FirebaseFirestore.instance.collection('Google Users').doc(userId);
        await userRef.update({
          'photoUrl': imageUrl,
        });
      } else {
        // If authenticated with other methods, save the photo in 'SignUp Users' collection
        final userRef =
            FirebaseFirestore.instance.collection('SignUp Users').doc(userId);
        await userRef.update({
          'photoUrl': imageUrl,
        });
      }
    } catch (error) {
      messenger.clearSnackBars();
      messenger.showSnackBar(
        const SnackBar(
          content: Text('Something went wrong'),
        ),
      );
    }
  }

  void pickImage() async {
    final messenger = ScaffoldMessenger.of(context);
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    //pickedImage can be null if user open camera and press backbutton
    if (pickedImage == null) {
      return;
    }
    //if image is taken then this will happen
    try {
      setState(() {
        pickedImageFile = File(pickedImage.path);
        isUploading = true; // Set loading to true
      });
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_images')
          .child('$userId.jpg');
      await storageRef.putFile(pickedImageFile!);
      final imageUrl = await storageRef.getDownloadURL();
      saveProfilePictureUrl(userId, imageUrl);
      // Update user's photoURL in FirebaseAuth
      await FirebaseAuth.instance.currentUser!.updatePhotoURL(imageUrl);
      setState(() {
        isUploading = false; // Set loading to false
      });
    } catch (error) {
      setState(() {
        isUploading = false; // Set loading to false
      });
      messenger.clearSnackBars();
      messenger.showSnackBar(
        const SnackBar(
          content: Text('Something went wrong'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    // final user = FirebaseAuth.instance.currentUser;
    final userAsyncValue = ref.watch(userProvider);

    return DrawerHeader(
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primary.withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: userAsyncValue.when(
        data: (userProfile) {
          final photoUrl = userProfile.photoUrl ?? '';

          return Row(
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: isUploading
                        ? null
                        : pickImage, // Add functionality to change profile picture if needed
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      height: screenSize.height * 0.11,
                      width: screenSize.height * 0.11,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          60,
                        ),
                      ),
                      child: isUploading // Show loading indicator if uploading
                          ? Container(
                              alignment: Alignment.center,
                              height: screenSize.height * 0.11,
                              width: screenSize.height * 0.11,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(
                                  60,
                                ),
                              ),
                              child: const CircularProgressIndicator())
                          : photoUrl.isNotEmpty
                              ? FadeInImage(
                                  fit: BoxFit.cover,
                                  placeholder: MemoryImage(kTransparentImage),
                                  image: CachedNetworkImageProvider(
                                    photoUrl,
                                    cacheManager: CacheManager(Config(
                                      'customCacheKey',
                                      stalePeriod: const Duration(days: 7),
                                    )),
                                  ),
                                  fadeInDuration:
                                      const Duration(milliseconds: 300),
                                  fadeOutDuration:
                                      const Duration(milliseconds: 100),
                                  fadeOutCurve: Curves.easeOut,
                                  fadeInCurve: Curves.easeIn,
                                )
                              : Container(
                                  alignment: Alignment.center,
                                  height: screenSize.height * 0.11,
                                  width: screenSize.height * 0.11,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(
                                      60,
                                    ),
                                  ),
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    'Add a Photo',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                        ),
                                  )),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Text(
                    userProfile.name,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                  ),
                  Text(
                    userProfile.email,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimary
                              .withOpacity(0.8),
                        ),
                  ),
                ],
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Text('Error: $error'),
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'dart:io';

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter_cache_manager/flutter_cache_manager.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:transparent_image/transparent_image.dart';

// class DrawerHeaderSet extends StatefulWidget {
//   const DrawerHeaderSet({
//     super.key,
//   });

//   @override
//   State<DrawerHeaderSet> createState() => _DrawerHeaderSetState();
// }

// class _DrawerHeaderSetState extends State<DrawerHeaderSet> {
//   final user = FirebaseAuth.instance.currentUser;
//   String? userName;
//   String? userEmail;
//   String? userPhoto;
//   String? photoUrl;
//   File? pickedImageFile;
//   String oUserName = 'loading..';
//   bool isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     // Call fetchUserData only when the widget is first initialized
//     fetchUserData();
//   }

//   Future<void> fetchUserData() async {
//     setState(() {
//       isLoading = true;
//     });
//     final userData = await FirebaseFirestore.instance
//         .collection('SignUp Users')
//         .doc(user!.uid)
//         .get();
//     oUserName = userData.data()!['name'];
//     photoUrl = userData.data()!['photoUrl'];
//     setState(() {
//       isLoading = false;
//     });
//   }

//   Future<void> saveProfilePictureUrl(String userId, String imageUrl) async {
//     final messenger = ScaffoldMessenger.of(context);
//     try {
//       final userRef =
//           FirebaseFirestore.instance.collection('SignUp Users').doc(userId);
//       await userRef.update({
//         'photoUrl': imageUrl,
//       });
//     } catch (error) {
//       messenger.clearSnackBars();
//       messenger.showSnackBar(
//         const SnackBar(
//           content: Text('Something went wrong'),
//         ),
//       );
//     }
//   }

//   void pickImage() async {
//     final messenger = ScaffoldMessenger.of(context);
//     final pickedImage = await ImagePicker().pickImage(
//       source: ImageSource.gallery,
//       imageQuality: 50,
//     );
//     //pickedImage can be null if user open camera and press backbutton
//     if (pickedImage == null) {
//       return;
//     }
//     //if image is taken then this will happen
//     try {
//       setState(() {
//         pickedImageFile = File(pickedImage.path);
//       });
//       final userId = FirebaseAuth.instance.currentUser!.uid;
//       final storageRef = FirebaseStorage.instance
//           .ref()
//           .child('profile_images')
//           .child('$userId.jpg');
//       await storageRef.putFile(pickedImageFile!);
//       final imageUrl = await storageRef.getDownloadURL();
//       saveProfilePictureUrl(userId, imageUrl);
//     } catch (error) {
//       messenger.clearSnackBars();
//       messenger.showSnackBar(
//         const SnackBar(
//           content: Text('Something went wrong'),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;

//     if (user != null) {
//       userPhoto = user!.photoURL;
//       userName = user!.displayName;
//       userEmail = user!.email;
//     }
//     return DrawerHeader(
//       margin: EdgeInsets.zero,
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             Theme.of(context).colorScheme.primary,
//             Theme.of(context).colorScheme.primary.withOpacity(0.7),
//           ],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//       ),
//       child: Row(
//         children: [
//           Column(
//             children: [
//               if (userPhoto != null || photoUrl != null)
//                 InkWell(
//                   onTap: userPhoto != null ? null : pickImage,
//                   child: Container(
//                     clipBehavior: Clip.hardEdge,
//                     height: screenSize.height * 0.11,
//                     width: screenSize.height * 0.11,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(
//                         60,
//                       ),
//                     ),
//                     child: FadeInImage(
//                       fit: BoxFit.cover,
//                       placeholder:
//                           // Placeholder image
//                           MemoryImage(kTransparentImage),
//                       image: CachedNetworkImageProvider(
//                         photoUrl != null ? photoUrl! : userPhoto!,
//                         cacheManager: CacheManager(Config(
//                           'customCacheKey',
//                           stalePeriod: const Duration(days: 7),
//                         )),
//                       ),

//                       fadeInDuration: const Duration(milliseconds: 300),
//                       fadeOutDuration: const Duration(milliseconds: 100),
//                       // Optional parameters for customizing the fade-in effect
//                       fadeOutCurve: Curves.easeOut,
//                       fadeInCurve: Curves.easeIn,
//                     ),
//                     // child: CachedNetworkImage(
//                     //   cacheManager: CacheManager(
//                     //     Config(
//                     //       'customCacheKey',
//                     //       stalePeriod: const Duration(days: 7),
//                     //     ),
//                     //   ),
//                     //   imageUrl: photoUrl != null ? photoUrl! : userPhoto!,
//                     //   fit: BoxFit.cover,
//                     //   placeholder: (context, url) =>
//                     //       const CircularProgressIndicator(),
//                     //   errorWidget: (context, url, error) =>
//                     //       const Icon(Icons.error),
//                     // ),
//                   ),
//                 ),
//               if (userPhoto == null && photoUrl == null)
//                 InkWell(
//                   onTap: isLoading ? null : pickImage,
//                   child: Container(
//                     alignment: Alignment.center,
//                     height: screenSize.height * 0.11,
//                     width: screenSize.height * 0.11,
//                     decoration: BoxDecoration(
//                       color: Colors.black.withOpacity(0.5),
//                       borderRadius: BorderRadius.circular(
//                         60,
//                       ),
//                     ),
//                     child: isLoading == false
//                         ? Text(
//                             textAlign: TextAlign.center,
//                             'Add a Photo',
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .titleMedium!
//                                 .copyWith(
//                                   fontWeight: FontWeight.w600,
//                                   color:
//                                       Theme.of(context).colorScheme.onPrimary,
//                                 ),
//                           )
//                         : const CircularProgressIndicator(),
//                   ),
//                 ),
//               if (photoUrl == null)
//                 SizedBox(
//                   height:
//                       (screenSize.height - MediaQuery.of(context).padding.top) *
//                           0.01,
//                 ),
//               Text(
//                 userName != null ? userName! : oUserName,
//                 style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                       color: Theme.of(context).colorScheme.onPrimary,
//                     ),
//               ),
//               Text(
//                 userEmail!,
//                 style: Theme.of(context).textTheme.bodySmall!.copyWith(
//                       color: Theme.of(context)
//                           .colorScheme
//                           .onPrimary
//                           .withOpacity(0.8),
//                     ),
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
