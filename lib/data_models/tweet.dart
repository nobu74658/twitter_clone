class Tweet {
  String tweetId;
  String userId;
  int favorite;
  String caption;
  String? userIcon;
  String userName;
  DateTime postDateTime;

//<editor-fold desc="Data Methods">

  Tweet({
    required this.tweetId,
    required this.userId,
    required this.favorite,
    required this.caption,
    this.userIcon,
    required this.userName,
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
          caption == other.caption &&
          userIcon == other.userIcon &&
          userName == other.userName &&
          postDateTime == other.postDateTime);

  @override
  int get hashCode =>
      tweetId.hashCode ^
      userId.hashCode ^
      favorite.hashCode ^
      caption.hashCode ^
      userIcon.hashCode ^
      userName.hashCode ^
      postDateTime.hashCode;

  @override
  String toString() {
    return 'Tweet{' +
        ' tweetId: $tweetId,' +
        ' userId: $userId,' +
        ' favorite: $favorite,' +
        ' caption: $caption,' +
        ' userIcon: $userIcon,' +
        ' userName: $userName,' +
        ' postDateTime: $postDateTime,' +
        '}';
  }

  Tweet copyWith({
    String? postId,
    String? userId,
    int? favorite,
    String? caption,
    String? userIcon,
    String? userName,
    DateTime? postDateTime,
  }) {
    return Tweet(
      tweetId: postId ?? this.tweetId,
      userId: userId ?? this.userId,
      favorite: favorite ?? this.favorite,
      caption: caption ?? this.caption,
      userIcon: userIcon ?? this.userIcon,
      userName: userName ?? this.userName,
      postDateTime: postDateTime ?? this.postDateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'postId': this.tweetId,
      'userId': this.userId,
      'favorite': this.favorite,
      'caption': this.caption,
      'userIcon': this.userIcon,
      'userName': this.userName,
      'postDateTime': this.postDateTime.toIso8601String(),
    };
  }

  factory Tweet.fromMap(Map<String, dynamic> map) {
    return Tweet(
      tweetId: map['tweetId'] as String,
      userId: map['userId'] as String,
      favorite: map['favorite'] as int,
      caption: map['caption'] as String,
      userIcon: map['userIcon'] as String?,
      userName: map['userName'] as String,
      postDateTime: DateTime.parse(map['postDateTime'] as String),
    );
  }

//</editor-fold>
}
