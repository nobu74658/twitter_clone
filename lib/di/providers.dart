import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:twitter_clone/models/db/database_manager.dart';
import 'package:twitter_clone/models/repositories/user_repository.dart';
import 'package:twitter_clone/view_model/sign_in_up_view_model.dart';
import 'package:twitter_clone/view_model/name_field_view_model.dart';

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
];

List<SingleChildWidget> viewModels = [
  ChangeNotifierProvider<SignInUpViewModel>(
    create: (context) => SignInUpViewModel(
      userRepository: context.read<UserRepository>(),
    ),
  ),
  ChangeNotifierProvider<NameFieldViewModel>(
    create: (context) => NameFieldViewModel(),
  ),
];
