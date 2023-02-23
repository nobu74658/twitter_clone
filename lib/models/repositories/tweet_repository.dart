import 'package:twitter_clone/data_models/tweet.dart';
import 'package:twitter_clone/models/db/database_manager.dart';
import 'package:uuid/uuid.dart';

class TweetRepository {
  TweetRepository({required this.dbManager});

  final DatabaseManager dbManager;

  Future<void> postTweet({
    required String userId,
    required String desc,
  }) async {
    String tweetId = Uuid().v1();
    Tweet tweet = Tweet(
      tweetId: tweetId,
      userId: userId,
      favorite: 0,
      desc: desc,
      postDateTime: DateTime.now(),
    );
    await dbManager.insertTweet(tweet);
  }

  Future<void> deleteTweet(String tweetId) async {
    await dbManager.deleteTweet(tweetId);
  }
}
