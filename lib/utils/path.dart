import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/view/common/screen/error_screen.dart';
import 'package:twitter_clone/view/sign_in_up/screens/check_invite_email.dart';
import 'package:twitter_clone/view/sign_in_up/screens/customize_screen.dart';
import 'package:twitter_clone/view/sign_in_up/screens/email_reset_confirm_screen.dart';
import 'package:twitter_clone/view/sign_in_up/screens/pass_reset_confirm_screen.dart';
import 'package:twitter_clone/view/sign_in_up/screens/register_confirm_screen.dart';
import 'package:twitter_clone/view/sign_in_up/screens/auth_screen.dart';
import 'package:twitter_clone/view/sign_in_up/screens/reset_auth_screen.dart';
import 'package:twitter_clone/view/top/bottom_navigation_bar.dart';
import 'package:twitter_clone/view/top/pages/edit_profile_page.dart';
import 'package:twitter_clone/view/top/pages/favorite_tweet_page.dart';
import 'package:twitter_clone/view/top/pages/follow_follower_page.dart';
import 'package:twitter_clone/view/top/pages/other_user_page.dart';
import 'package:twitter_clone/view/top/pages/post_tweet_page.dart';
import 'package:twitter_clone/view/top/pages/profile_page.dart';
import 'package:twitter_clone/view/top/pages/time_line_page.dart';
import 'package:twitter_clone/view/top/screens/top_screen.dart';
import 'package:twitter_clone/view_model/favorite_view_model.dart';
import 'package:twitter_clone/view_model/tweet_view_model.dart';

import '../view_model/user_view_model.dart';

const String kInitialPath = "/";
const String kCheckInviteEmailPath = "/check-invite-email";
const String kRegisterPath = "/register";
const String kRegisterConfirmPath = "/register-confirm";
const String kCustomizePath = "/customize";
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
const String kTimeLinePath = "/time-line";
const String kFavoriteTweetPath = "/favorite-tweet";
const String kProfilePath = "/profile";

final GoRouter router = GoRouter(
  initialLocation: kInitialPath,
  redirect: (context, state) async {
    await _future(context);
    final firebaseUser = FirebaseAuth.instance.currentUser;
    String? path;
    if (firebaseUser == null) {
      switch (state.location) {
        case kInitialPath:
          path = kLoginPath;
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
        case "":
          path = kTimeLinePath;
          break;
        case kInitialPath:
          path = kTimeLinePath;
          break;
        case kRegisterPath:
          path = kTimeLinePath;
          break;
        case kLoginPath:
          path = kTimeLinePath;
          break;
        case kRegisterConfirmPath:
          path = kTimeLinePath;
          break;
        case kCustomizePath:
          path = kTimeLinePath;
          break;
        case kCheckInviteEmailPath:
          path = kTimeLinePath;
          break;
        default:
      }
    }
    return path;
  },
  routes: [
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
    ShellRoute(
      builder: (BuildContext context, GoRouterState state, child) {
        return BottomNavigation(context: context, child: child);
      },
      routes: [
        GoRoute(
          path: kTimeLinePath,
          builder: (context, state) {
            return TimeLinePage();
          },
        ),
        GoRoute(
          path: kFavoriteTweetPath,
          builder: (context, state) => FavoriteTweetPage(),
        ),
        GoRoute(
          path: kProfilePath,
          pageBuilder: (context, state) => const MaterialPage(
            child: ProfilePage(),
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
    ),
  ],
  errorPageBuilder: (context, state) => const MaterialPage(
    child: ErrorScreen(),
  ),
);

Future<void> _future(BuildContext context) async {
  final userViewModel = context.read<UserViewModel>();
  final favoriteViewModel = context.read<FavoriteViewModel>();
  final tweetViewModel = context.read<TweetViewModel>();
  await userViewModel.getCurrentUser();
  await tweetViewModel.getCurrentUserTweet();
  await favoriteViewModel.getFavoriteTweets();
}
