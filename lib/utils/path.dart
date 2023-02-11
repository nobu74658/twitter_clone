import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/view/sign_in_up/screens/auth_code_screen.dart';
import 'package:twitter_clone/view/sign_in_up/screens/customize_screen.dart';
import 'package:twitter_clone/view/sign_in_up/screens/privacy_screen.dart';
import 'package:twitter_clone/view/sign_in_up/screens/register_confirm_screen.dart';
import 'package:twitter_clone/view/sign_in_up/screens/register_screen.dart';
import 'package:twitter_clone/view/top/screens/top_screen.dart';

const kInitialPath = "/";
const kCheckInviteEmailPath = "/check-invite-email";
const kRegisterPath = "/register";
const kRegisterConfirmPath = "/register-confirm";
const kCustomizePath = "/customize";
const kTopPath = "/top";
const kPath = "";

final GoRouter router = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: kInitialPath,
      pageBuilder: (context, state) => const MaterialPage(
        child: RegisterScreen(),
      ),
    ),
    GoRoute(
      path: kTopPath,
      pageBuilder: (context, state) => const MaterialPage(
        child: TopScreen(),
      ),
    ),
    GoRoute(
      path: kRegisterPath,
      pageBuilder: (context, state) => const MaterialPage(
        child: RegisterScreen(),
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
  ],
  errorPageBuilder: (context, state) => const MaterialPage(
    child: RegisterScreen(),
  ),
);
