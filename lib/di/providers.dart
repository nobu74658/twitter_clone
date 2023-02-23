import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:twitter_clone/models/db/database_manager.dart';
import 'package:twitter_clone/models/repositories/tweet_repository.dart';
import 'package:twitter_clone/models/repositories/user_repository.dart';
import 'package:twitter_clone/view_model/follow_unfollow_view_model.dart';
import 'package:twitter_clone/view_model/page_view_model.dart';
import 'package:twitter_clone/view_model/sign_in_up_view_model.dart';
import 'package:twitter_clone/view_model/tweet_view_model.dart';
import 'package:twitter_clone/view_model/user_view_model.dart';

List<SingleChildWidget> globalProviders = [
  ...independentModels,
  ...dependentModels,
  ...viewModels
];

List<SingleChildWidget> independentModels = [
  Provider<DatabaseManager>(
    create: (_) => DatabaseManager(),
  ),
];

List<SingleChildWidget> dependentModels = [
  ProxyProvider<DatabaseManager, UserRepository>(
    update: (_, dbManager, repo) => UserRepository(dbManager: dbManager),
  ),
  ProxyProvider<DatabaseManager, TweetRepository>(
    update: (_, dbManager, repo) => TweetRepository(dbManager: dbManager),
  ),
];

List<SingleChildWidget> viewModels = [
  ChangeNotifierProvider<SignInUpViewModel>(
    create: (context) => SignInUpViewModel(
      userRepository: context.read<UserRepository>(),
    ),
  ),
  ChangeNotifierProvider<UserViewModel>(
    create: (context) => UserViewModel(
      userRepository: context.read<UserRepository>(),
    ),
  ),
  ChangeNotifierProvider<TweetViewModel>(
    create: (context) => TweetViewModel(
      userRepository: context.read<UserRepository>(),
      tweetRepository: context.read<TweetRepository>(),
    ),
  ),
  ChangeNotifierProvider<PageViewModel>(
    create: (context) => PageViewModel(),
  ),
  ChangeNotifierProvider<FollowUnFollowViewModel>(
    create: (context) => FollowUnFollowViewModel(),
  ),
];
