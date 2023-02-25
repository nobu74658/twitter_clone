import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/view/common/screen/error_screen.dart';
import 'package:twitter_clone/view/common/screen/splash_screen.dart';
import 'package:twitter_clone/view/sign_in_up/screens/check_invite_email.dart';
import 'package:twitter_clone/view/sign_in_up/screens/customize_screen.dart';
import 'package:twitter_clone/view/sign_in_up/screens/email_reset_confirm_screen.dart';
import 'package:twitter_clone/view/sign_in_up/screens/pass_reset_confirm_screen.dart';
import 'package:twitter_clone/view/sign_in_up/screens/register_confirm_screen.dart';
import 'package:twitter_clone/view/sign_in_up/screens/auth_screen.dart';
import 'package:twitter_clone/view/sign_in_up/screens/reset_auth_screen.dart';
import 'package:twitter_clone/view/top/pages/edit_profile_page.dart';
import 'package:twitter_clone/view/top/pages/follow_follower_page.dart';
import 'package:twitter_clone/view/top/pages/other_user_page.dart';
import 'package:twitter_clone/view/top/pages/post_tweet_page.dart';
import 'package:twitter_clone/view/top/screens/top_screen.dart';

const String kInitialPath = "/";
const String kCheckInviteEmailPath = "/check-invite-email";
const String kRegisterPath = "/register";
const String kRegisterConfirmPath = "/register-confirm";
const String kCustomizePath = "/customize";
const String kTopPath = "/top";
const String kLoginPath = "/login";
const String kEditProfilePath = "/edit-profile";
const String kPassResetConfirmPath = "/pass-reset-confirm";
const String kPassResetAuthPath = "/pass-reset-auth";
const String kEmailResetConfirmPath = "/email-reset-confirm";
const String kEmailResetAuthPath = "/email-reset-auth";
const String kPostTweetPath = "/post-tweet";
const String kFollowPath = "/follow";
const String kFollowerPath = "/follower";
const String kOtherUserPath = "/other-user";
const String kPath = "";

final GoRouter router = GoRouter(
  initialLocation: kInitialPath,
  redirect: (context, state) {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    String? path;
    if (firebaseUser == null) {
      switch (state.location) {
        case kInitialPath:
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
    } else {
      switch (state.location) {
        case kInitialPath:
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
    GoRoute(
      path: kEditProfilePath,
      pageBuilder: (context, state) => const MaterialPage(
        child: EditProfilePage(),
      ),
    ),
    GoRoute(
      path: kPassResetConfirmPath,
      pageBuilder: (context, state) => const MaterialPage(
        child: PassResetConfirmScreen(),
      ),
    ),
    GoRoute(
      path: kPassResetAuthPath,
      pageBuilder: (context, state) => const MaterialPage(
        child: ResetAuthScreen(
          isPassReset: true,
        ),
      ),
    ),
    GoRoute(
      path: kEmailResetConfirmPath,
      pageBuilder: (context, state) => const MaterialPage(
        child: EmailResetConfirmScreen(),
      ),
    ),
    GoRoute(
      path: kEmailResetAuthPath,
      pageBuilder: (context, state) => const MaterialPage(
        child: ResetAuthScreen(isPassReset: false),
      ),
    ),
    GoRoute(
      path: kPostTweetPath,
      pageBuilder: (context, state) => const MaterialPage(
        child: PostTweetPage(),
      ),
    ),
    GoRoute(
      path: kFollowPath,
      pageBuilder: (context, state) => const MaterialPage(
        child: FollowFollowerPage(),
      ),
    ),
    GoRoute(
      path: kFollowerPath,
      pageBuilder: (context, state) => const MaterialPage(
        child: FollowFollowerPage(isFollow: false),
      ),
    ),
    GoRoute(
      path: kOtherUserPath,
      pageBuilder: (context, state) => const MaterialPage(
        child: TopScreen(),
      ),
    ),
    GoRoute(
      path: "$kOtherUserPath/:user_id",
      pageBuilder: (context, state) {
        String userId = state.params['user_id'] ?? "";
        return MaterialPage(
          child: OtherUserPage(otherUserId: userId),
        );
      },
    ),
  ],
  errorPageBuilder: (context, state) => const MaterialPage(
    child: ErrorScreen(),
  ),
);
