import 'package:flutter/material.dart';
import 'package:twitter_clone/utils/path.dart';
import 'package:twitter_clone/view/sign_in_up/screens/register_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return MaterialApp.router(
    //   routeInformationProvider: router.routeInformationProvider,
    //   routeInformationParser: router.routeInformationParser,
    //   routerDelegate: router.routerDelegate,
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //   ),
    // );
    return MaterialApp(
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 18),
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: RegisterScreen(),
    );
  }
}
