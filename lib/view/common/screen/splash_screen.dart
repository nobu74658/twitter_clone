import 'package:flutter/material.dart';
import 'package:twitter_clone/utils/authentication.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/logo.png",
              color: Colors.white,
            ),
            const SizedBox(height: 40),
            FutureBuilder(
              future: Authentication.initializeFirebase(context: context),
              builder: (context, snapshot) {
                return const CircularProgressIndicator(
                  color: Colors.white,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
