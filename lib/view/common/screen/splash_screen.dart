// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:twitter_clone/utils/authentication.dart';
// import 'package:twitter_clone/utils/path.dart';

// class SplashScreen extends StatelessWidget {
//   const SplashScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.lightBlue,
//       body: Center(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(
//               "assets/images/logo.png",
//               color: Colors.white,
//             ),
//             const SizedBox(height: 40),
//             FutureBuilder(
//               future: initializeFirebase(context: context),
//               builder: (context, snapshot) {
//                 return const CircularProgressIndicator(
//                   color: Colors.white,
//                 );
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Future<String> _initializeFirebase({
//     required BuildContext context,
//   }) async {
//     User? user = FirebaseAuth.instance.currentUser;
//     await Future.delayed(const Duration(seconds: 3));
    
//   }
// }
