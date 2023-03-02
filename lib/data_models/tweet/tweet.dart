import 'package:freezed_annotation/freezed_annotation.dart';

part 'tweet.freezed.dart';
part 'tweet.g.dart';

@freezed
class Tweet with _$Tweet {
  factory Tweet({
    required String tweetId,
    required String userId,
    required String userName,
    String? userIcon,
    required String bio,
    required int favoriteNum,
    required String desc,
    String? imageUrl,
    required DateTime createdAt,
  }) = _Tweet;

  factory Tweet.fromJson(Map<String, dynamic> json) => _$TweetFromJson(json);
}
