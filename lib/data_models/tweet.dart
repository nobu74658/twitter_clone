class Tweet {
  String tweetId;
  String userId;
  int favorite;
  String desc;
  DateTime postDateTime;

//<editor-fold desc="Data Methods">

  Tweet({
    required this.tweetId,
    required this.userId,
    required this.favorite,
    required this.desc,
    required this.postDateTime,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tweet &&
          runtimeType == other.runtimeType &&
          tweetId == other.tweetId &&
          userId == other.userId &&
          favorite == other.favorite &&
          desc == other.desc &&
          postDateTime == other.postDateTime);

  @override
  int get hashCode =>
      tweetId.hashCode ^
      userId.hashCode ^
      favorite.hashCode ^
      desc.hashCode ^
      postDateTime.hashCode;

  @override
  String toString() {
    return 'Tweet{' +
        ' tweetId: $tweetId,' +
        ' userId: $userId,' +
        ' favorite: $favorite,' +
        ' desc: $desc,' +
        ' postDateTime: $postDateTime,' +
        '}';
  }

  Tweet copyWith({
    String? postId,
    String? userId,
    int? favorite,
    String? desc,
    DateTime? postDateTime,
  }) {
    return Tweet(
      tweetId: postId ?? this.tweetId,
      userId: userId ?? this.userId,
      favorite: favorite ?? this.favorite,
      desc: desc ?? this.desc,
      postDateTime: postDateTime ?? this.postDateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tweetId': this.tweetId,
      'userId': this.userId,
      'favorite': this.favorite,
      'desc': this.desc,
      'postDateTime': this.postDateTime.toIso8601String(),
    };
  }

  factory Tweet.fromMap(Map<String, dynamic> map) {
    return Tweet(
      tweetId: map['tweetId'] as String,
      userId: map['userId'] as String,
      favorite: map['favorite'] as int,
      desc: map['desc'] as String,
      postDateTime: DateTime.parse(map['postDateTime'] as String),
    );
  }

//</editor-fold>
}
