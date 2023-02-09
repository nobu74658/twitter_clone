import 'package:go_router/go_router.dart';
import 'package:twitter_clone/view/sign_in_up/screens/auth_code_screen.dart';
import 'package:twitter_clone/view/sign_in_up/screens/customize_screen.dart';
import 'package:twitter_clone/view/sign_in_up/screens/privacy_screen.dart';
import 'package:twitter_clone/view/sign_in_up/screens/register_screen.dart';

final router = GoRouter(initialLocation: "/", routes: [
  GoRoute(
      path: "/register",
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: RegisterScreen())),
  GoRoute(
      path: "/customize",
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: CustomizeScreen())),
  GoRoute(
      path: "/privacy",
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: PrivacyScreen())),
  GoRoute(
      path: "/auth-code",
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: AuthCodeScreen())),
]);
