import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:twitter_clone/data_models/user.dart';
import 'package:twitter_clone/models/db/database_manager.dart';
class UserRepository {
  final DatabaseManager dbManager;

  UserRepository({required this.dbManager});

  static User? currentUser;

  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
}