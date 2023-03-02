import 'dart:io';

import 'package:twitter_clone/data_models/tweet/tweet.dart';
import 'package:twitter_clone/models/db/database_manager.dart';
import 'package:uuid/uuid.dart';

class TweetRepository {
  TweetRepository({required this.dbManager});

  final DatabaseManager dbManager;

  Future<Tweet> postTweet({
    required String userId,
    required String userName,
    required File? imageFile,
    required String bio,
    String? userIcon,
    required String desc,
  }) async {
    final storageId = Uuid().v1();
    String? imageUrl;
    if (imageFile != null) {
      imageUrl = await dbManager.uploadImageToStorage(imageFile, storageId);
    }
    String tweetId = Uuid().v1();
    Tweet tweet = Tweet(
      tweetId: tweetId,
      userId: userId,
      favoriteNum: 0,
      desc: desc,
      createdAt: DateTime.now(),
      userName: userName,
      bio: bio,
      userIcon: userIcon,
      imageUrl: imageUrl,
    );
    await dbManager.setTweet(tweet);
    return tweet;
  }

  Future<void> deleteTweet(String tweetId) async {
    await dbManager.deleteTweet(tweetId);
  }
}
