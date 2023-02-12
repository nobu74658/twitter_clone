import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/view/common/screen/error_screen.dart';
import 'package:twitter_clone/view/common/screen/splash_screen.dart';
import 'package:twitter_clone/view/sign_in_up/screens/check_invite_email.dart';
import 'package:twitter_clone/view/sign_in_up/screens/customize_screen.dart';
import 'package:twitter_clone/view/sign_in_up/screens/register_confirm_screen.dart';
import 'package:twitter_clone/view/sign_in_up/screens/auth_screen.dart';
import 'package:twitter_clone/view/top/screens/top_screen.dart';

const String kInitialPath = "/";
const String kCheckInviteEmailPath = "/check-invite-email";
const String kRegisterPath = "/register";
const String kRegisterConfirmPath = "/register-confirm";
const String kCustomizePath = "/customize";
const String kTopPath = "/top";
const String kLoginPath = "/login";
const String kPath = "";

final GoRouter router = GoRouter(
  initialLocation: kInitialPath,
  redirect: (context, state) {
    final currentUser = FirebaseAuth.instance.currentUser;
    String? path;
    if (currentUser == null) {
      switch (state.location) {
        case kInitialPath:
          // path = kLoginPath;
          path = kInitialPath;
          break;
        case kRegisterPath:
          break;
        case kLoginPath:
          break;
        case kRegisterConfirmPath:
          break;
        case kCustomizePath:
          break;
        case kCheckInviteEmailPath:
          break;
        default:
          path = kLoginPath;
      }
      print(state.location);
    } else {
      print("loggedIn: ${state.location}");
      switch (state.location) {
        case kInitialPath:
          // path = kTopPath;
          path = kInitialPath;
          break;
        case kRegisterPath:
          path = kTopPath;
          break;
        case kLoginPath:
          path = kTopPath;
          break;
        case kRegisterConfirmPath:
          path = kTopPath;
          break;
        case kCustomizePath:
          path = kTopPath;
          break;
        case kCheckInviteEmailPath:
          path = kTopPath;
          break;
        default:
      }
    }
    return path;
  },
  routes: [
    GoRoute(
      path: kInitialPath,
      pageBuilder: (context, state) => const MaterialPage(
        child: SplashScreen(),
      ),
    ),
    GoRoute(
      path: kTopPath,
      pageBuilder: (context, state) => const MaterialPage(
        child: TopScreen(),
      ),
    ),
    GoRoute(
      path: kLoginPath,
      pageBuilder: (context, state) => const MaterialPage(
        child: AuthScreen(isRegister: false),
      ),
    ),
    GoRoute(
      path: kRegisterPath,
      pageBuilder: (context, state) => const MaterialPage(
        child: AuthScreen(),
      ),
    ),
    GoRoute(
      path: kRegisterConfirmPath,
      pageBuilder: (context, state) => const MaterialPage(
        child: RegisterConfirmScreen(),
      ),
    ),
    GoRoute(
      path: kCustomizePath,
      pageBuilder: (context, state) => const MaterialPage(
        child: CustomizeScreen(),
      ),
    ),
    GoRoute(
      path: kCheckInviteEmailPath,
      pageBuilder: (context, state) => const MaterialPage(
        child: CheckInviteEmailScreen(),
      ),
    ),
  ],
  errorPageBuilder: (context, state) => const MaterialPage(
    child: ErrorScreen(),
  ),
);
